# ecotext

Typst で日本語の書籍を書くための環境（Nix flake）。

## セットアップ

```console
$ direnv allow
```

`.envrc` の `use flake` により、`typst` に日本語フォント（Noto Serif CJK JP / Noto Sans CJK JP / Source Han Mono）が組み込まれた状態でシェルに入ります。

## 使い方

PDF のビルド:

```console
$ typst compile book.typ
```

ファイル保存時に自動で再ビルド（プレビュー用）:

```console
$ typst watch book.typ
```

利用可能なフォントの一覧:

```console
$ typst fonts
```

Nix ファイルのフォーマット（alejandra）:

```console
$ nix fmt .
```

## レイアウト

- 判型: B5 判（JIS B 列 182mm × 257mm）
- 本文: Noto Serif CJK JP 10pt、両端揃え、一字下げ
- 見出し: Noto Sans CJK JP、章見出しは「第N章」形式で改ページから開始
- 余白: のど 22mm / 小口 18mm / 天 18mm / 地 22mm
- ノンブル: 下中央

書名・著者名は `book.typ` 内の `set document` とタイトルページを編集してください。

## direnv を使わない場合

```console
$ nix develop
$ nix run .#typst -- compile book.typ
```

## フォントの追加

`flake.nix` の `fonts` リストにパッケージを追加すると、Typst から自動的に認識されます（フォントパスは `TYPST_FONT_PATHS` 経由で渡されます）。

## Typst パッケージの利用

ルビ（ふりがな）などが必要になったら、Typst Universe のパッケージ（例: `@preview/rubby`）を `book.typ` で `#import` すると、初回コンパイル時に自動ダウンロードされます。
