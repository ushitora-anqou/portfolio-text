// Japanese textbook template.
// Paper: JIS B5 (182mm x 257mm), body font: Noto Serif CJK JP.

#import "setup.typ": (
  body-font, heading-font, mono-font, chapter-numbering,
  math-env-kind, env-counter, definition, axiom, theorem,
  lemma, corollary, example, remark, proof, eqref, chapter-tag-at, appendix-count,
)

#set document(
  title: [時価総額加重平均ポートフォリオの理論],
  author: ("著者名",),
)

#set text(
  lang: "ja",
  region: "JP",
  font: body-font,
  size: 10pt,
)

// JIS B5 with book margins: wider at the spine (inside) and at the
// foot (bottom), following Japanese binding conventions.
#set page(
  width: 182mm,
  height: 257mm,
  margin: (inside: 22mm, outside: 18mm, top: 18mm, bottom: 22mm),
  binding: left,
  numbering: "1",
  number-align: center,
)

// Japanese-style paragraphs: justified, one-character first-line
// indent, no extra space between paragraphs.
#set par(
  justify: true,
  leading: 0.7em,
  spacing: 0.7em,
  first-line-indent: (amount: 1em, all: true),
)

#set heading(numbering: chapter-numbering)

#show raw: set text(font: mono-font)

// Numbered equations, numbered per chapter.
#set math.equation(numbering: (..nums) => context {
  "(" + chapter-tag-at(here()) + "." + str(nums.pos().first()) + ")"
})

// Theorem-like environments are numbered "N.M" from the environment
// counter at their own location, so both the label and cross
// references agree regardless of where the reference appears.
// Theorem-like environments run with body text alignment (start),
// not the figure default (center), and without first-line indents:
// their body starts right after the label, and lines resuming after
// a displayed equation must not be indented either.
#show figure.where(kind: math-env-kind): set align(start)
#show figure.where(kind: math-env-kind): set par(
  first-line-indent: (amount: 0pt, all: true),
)

#show figure.where(kind: math-env-kind): it => context block(
  above: 1.5em, below: 1.2em, width: 100%, breakable: true, {
    let ch = chapter-tag-at(here())
    text(
      font: heading-font, weight: 500,
    )[#it.supplement #(ch + ".")#it.counter.display(it.numbering)]
    h(1em)
    it.body
  },
)

// Cross references to theorem-like environments and numbered
// equations are built from the counters at the target's location.
#show ref: it => context {
  let els = query(it.target)
  if els.len() == 0 {
    it
  } else {
    let el = els.first()
    let loc = el.location()
    if el.func() == figure and el.kind == math-env-kind {
      let ch = chapter-tag-at(loc)
      let n = el.counter.at(loc).first()
      link(it.target)[#el.supplement #(ch + "." + str(n))]
    } else if el.func() == math.equation {
      let ch = chapter-tag-at(loc)
      let n = counter(math.equation).at(loc).first()
      link(it.target)[#("(" + ch + "." + str(n) + ")")]
    } else {
      it
    }
  }
}

// Each chapter starts on a new page and resets the environment and
// equation counters.
#show heading.where(level: 1): it => [
  #env-counter.update(0)
  #counter(math.equation).update(0)
  // Chapters open on a recto (odd) page, as in bound books.
  #pagebreak(to: "odd", weak: true)
  #block(above: 3em, below: 2em, breakable: false, {
    set text(font: heading-font, size: 16pt)
    if it.numbering != none [
      #counter(heading).display(it.numbering)
      #h(1em)
    ]
    it.body
  })
]

#show heading.where(level: 2): it => [
  #block(above: 2.2em, below: 1.2em, breakable: false, {
    set text(font: heading-font, size: 12.5pt)
    if it.numbering != none [
      #counter(heading).display(it.numbering)
      #h(0.75em)
    ]
    it.body
  })
]

#show heading.where(level: 3): it => [
  #block(above: 1.8em, below: 1em, breakable: false, {
    set text(font: heading-font, size: 11pt)
    if it.numbering != none [
      #counter(heading).display(it.numbering)
      #h(0.5em)
    ]
    it.body
  })
]

#show bibliography: set par(justify: false)

// ---------------------------------------------------------------------------
// Front matter

#align(center)[
  #v(2fr)
  #text(font: heading-font, size: 22pt)[時価総額加重平均ポートフォリオの理論]
  #v(0.4fr)
  #text(size: 12pt)[現代ポートフォリオ理論と CAPM から見た投資効率]
  #v(1.2fr)
  #text(size: 13pt)[著者名]
  #v(2fr)
]

#pagebreak()

// Table of contents.
#outline(
  title: [目次],
  depth: 2,
)

// ---------------------------------------------------------------------------
// Body

#include "chapters/01-introduction.typ"
#include "chapters/02-mathematics.typ"
#include "chapters/03-probability.typ"
#include "chapters/04-utility.typ"
#include "chapters/05-portfolio.typ"
#include "chapters/06-sharpe.typ"
#include "chapters/07-capm.typ"
#include "chapters/08-cap-weighted.typ"
#include "chapters/09-conclusion.typ"
#include "chapters/10-appendix-math.typ"
#include "chapters/11-appendix-probability.typ"
#include "chapters/12-appendix-vnm.typ"

// Index, built from term metadata registered at first occurrences,
// sorted by reading (kana).
#heading(numbering: none)[索引]
#context {
  let ms = query(metadata)
  let items = ()
  for m in ms {
    let v = m.value
    if type(v) == array and v.len() == 2 and v.at(0) == "term-index" {
      let page-no = counter(page).at(m.location()).first()
      items.push((kana: v.at(1).at("kana"), ja: v.at(1).at("ja"), en: v.at(1).at("en"), page: page-no))
    }
  }
  let sorted-items = items.sorted(key: it => it.kana)
  for it in sorted-items [
    #box(width: 70%)[#it.ja（#it.en）]#box(width: 1fr)[#it.page]#linebreak()
  ]
}

// References, numbered [1], [2], ... in order of first citation.
#bibliography(
  "references.bib",
  title: [参考文献],
  style: "ieee",
)
