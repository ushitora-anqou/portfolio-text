// Shared definitions: fonts and theorem-like environments.
// Imported by book.typ and every chapter.

#let body-font = ("Noto Serif CJK JP",)
#let heading-font = ("Noto Sans CJK JP",)
#let mono-font = ("Source Han Mono", "DejaVu Sans Mono")

// Numbering: "Chapter N" for level 1, "N.1", "N.1.1", ... below.
#let chapter-numbering(..nums) = {
  let ns = nums.pos()
  if ns.len() == 1 {
    "第" + str(ns.at(0)) + "章"
  } else {
    str(ns.at(0)) + "." + ns.slice(1).map(str).join(".")
  }
}

// Theorem-like environments: definitions, axioms, theorems,
// propositions, lemmas, corollaries, examples and remarks share one
// figure counter of kind "math-env", reset per chapter by a show rule
// in book.typ. The chapter part of "N.M" is resolved at each
// environment's own location, both when displayed and when referenced.
#let math-env-kind = "math-env"
#let env-counter = counter(figure.where(kind: "math-env"))

#let math-env(supplement, name: none, body) = figure(
  kind: math-env-kind,
  supplement: supplement,
  numbering: "1",
  scope: "column",
  outlined: false,
  body,
)

#let definition(name: none, body) = math-env("定義", name: name, body)
#let axiom(name: none, body) = math-env("公理", name: name, body)
#let theorem(name: none, body) = math-env("定理", name: name, body)
#let lemma(name: none, body) = math-env("補題", name: name, body)
#let corollary(name: none, body) = math-env("系", name: name, body)
#let example(name: none, body) = math-env("例", name: name, body)
#let remark(name: none, body) = math-env("注意", name: name, body)

// Proof environment, closed with a tombstone at the right margin.
// First-line indents are disabled so that text resuming after a
// displayed equation stays flush with the left edge. Equations inside
// a proof are unnumbered, following the convention that only
// equations referenced later carry numbers.
#let proof(body) = block(above: 1em, below: 1.4em, width: 100%, {
  set par(first-line-indent: (amount: 0pt, all: true))
  set math.equation(numbering: none)
  text(font: heading-font, weight: 500)[証明]
  h(1em)
  body
  linebreak()
  h(1fr)
  $square$
})

// Appendices are flagged by this counter (0 = main chapters, 1 =
// appendix A, 2 = appendix B, and so on). The chapter tag for
// numbering is resolved at a given location: digits in chapters,
// letters in the appendices.
#let appendix-count = counter("appendix")

// The letter of the n-th appendix: 1 -> "A", 2 -> "B", 3 -> "C", ...
#let appendix-letters = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
  "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
  "Y", "Z")

#let chapter-tag-at(loc) = {
  let a = appendix-count.at(loc).first()
  if a > 0 { appendix-letters.at(a - 1) } else { str(counter(heading).at(loc).first()) }
}

// Reference to a numbered equation, numbered per chapter at the
// equation's own location, e.g. eqref(<eq-minvar>) => (5.4).
#let eqref(label) = context {
  let eq = math.equation.at(label)
  let loc = eq.location()
  let ch = chapter-tag-at(loc)
  let n = counter(math.equation).at(loc).first()
  link(label)[#("(" + ch + "." + str(n) + ")")]
}

// Index machinery: terms are registered with a reading (kana) at their
// first occurrence via metadata; book.typ builds the index from them.
#let term-meta(entry) = metadata(("term-index", entry))
