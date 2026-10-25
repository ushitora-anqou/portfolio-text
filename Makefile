# Build the textbook PDF.
#
# Uses the direnv/nix develop environment when available, otherwise
# falls back to `nix develop` so the build also works in a plain shell.

TYPST := $(if $(shell command -v typst 2>/dev/null),typst,nix develop -c typst)

SOURCES := book.typ setup.typ references.bib $(wildcard chapters/*.typ)

.PHONY: build

build: book.pdf

book.pdf: $(SOURCES)
	$(TYPST) compile book.typ
