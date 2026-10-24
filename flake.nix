{
  description = "Japanese book writing environment with Typst";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = inputs: let
    # Japanese fonts used by the book. Typst discovers them through
    # the TYPST_FONT_PATHS environment variable, so builds do not
    # depend on system-installed fonts. The static (non-variable)
    # variants are used so that Typst resolves font weights
    # correctly.
    fonts = pkgs: [
      pkgs.noto-fonts-cjk-serif-static # body text (Noto Serif CJK JP)
      pkgs.noto-fonts-cjk-sans-static # headings (Noto Sans CJK JP)
      pkgs.source-han-mono # code (Source Han Mono)
    ];

    fontPaths = pkgs:
      inputs.nixpkgs.lib.concatStringsSep ":"
      (map (p: "${p}/share/fonts") (fonts pkgs));

    # typst wrapped with the project fonts baked in.
    typstWithFonts = pkgs:
      pkgs.symlinkJoin {
        name = "typst-with-japanese-fonts";
        paths = [pkgs.typst];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram "$out/bin/typst" \
            --prefix TYPST_FONT_PATHS : "${fontPaths pkgs}"
        '';
      };
  in {
    packages =
      builtins.mapAttrs (system: pkgs: rec {
        typst = typstWithFonts pkgs;
        default = typst;
      })
      inputs.nixpkgs.legacyPackages;

    devShells =
      builtins.mapAttrs (system: pkgs: {
        default = pkgs.mkShell {
          packages = [(typstWithFonts pkgs)];
        };
      })
      inputs.nixpkgs.legacyPackages;

    # `nix fmt` runs alejandra.
    formatter = builtins.mapAttrs (system: pkgs: pkgs.alejandra) inputs.nixpkgs.legacyPackages;
  };
}
