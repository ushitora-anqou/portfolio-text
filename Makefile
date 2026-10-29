# Build the textbook PDF.
#
# Uses the direnv/nix develop environment when available, otherwise
# falls back to `nix develop` so the build also works in a plain shell.

TYPST := $(if $(shell command -v typst 2>/dev/null),typst,nix develop -c typst)

SOURCES := book.typ setup.typ references.bib $(wildcard chapters/*.typ)

TITLE := 時価総額加重平均ポートフォリオの理論

# Release the textbook: create a GitHub release on origin/master and
# attach the built PDF to it.
#
# The tag defaults to the latest vN.M.K tag with the patch number
# bumped, or v0.1.0 when the repository has no version tags yet.
# Override it with `make release VERSION=v1.0.0`.

VERSION ?= $(shell latest=$$(git tag --list 'v[0-9]*.[0-9]*.[0-9]*' --sort=-v:refname | head -n1); \
	if [ -n "$$latest" ]; then \
		echo "$$latest" | awk -F. '{sub(/^v/, "", $$1); printf "v%d.%d.%d", $$1, $$2, $$3 + 1}'; \
	else \
		echo v0.1.0; \
	fi)

.PHONY: build release

build: book.pdf

book.pdf: $(SOURCES)
	$(TYPST) compile book.typ

release: book.pdf
	@if ! git ls-remote --exit-code --heads origin master | grep -q "$$(git rev-parse HEAD)"; then \
		echo "error: HEAD is not pushed to origin/master. Run 'git push' first." >&2; exit 1; \
	fi
	gh release create "$(VERSION)" book.pdf --title "『$(TITLE)』 $(VERSION)" --generate-notes
	@echo "Released $(VERSION) with book.pdf attached."
