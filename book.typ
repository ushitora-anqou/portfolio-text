// Japanese book template.
// Paper: JIS B5 (182mm x 257mm), body font: Noto Serif CJK JP.

#let body-font = ("Noto Serif CJK JP",)
#let heading-font = ("Noto Sans CJK JP",)
#let mono-font = ("Source Han Mono", "DejaVu Sans Mono")

// Numbering: "Chapter 1" for level 1, "1.1", "1.1.1", ... below.
#let chapter-numbering(..nums) = {
  let ns = nums.pos()
  if ns.len() == 1 {
    "第" + str(ns.at(0)) + "章"
  } else {
    str(ns.at(0)) + "." + ns.slice(1).map(str).join(".")
  }
}

#set document(
  title: [書籍タイトル],
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

// Each chapter starts on a new page.
#show heading.where(level: 1): it => [
  #pagebreak(weak: true)
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

// ---------------------------------------------------------------------------
// Front matter

#align(center)[
  #v(2fr)
  #text(font: heading-font, size: 24pt)[書籍タイトル]
  #v(1fr)
  #text(size: 13pt)[著者名]
  #v(2fr)
]

#pagebreak()

// Table of contents (only chapters, depth 1).
#outline(
  title: [目次],
  depth: 1,
)

// ---------------------------------------------------------------------------
// Body

= はじめに

これは日本語書籍テンプレートです。本文は*Noto Serif CJK JP*（源ノ明朝）で組まれ、約物や禁則処理は `set text(lang: "ja")` により日本語の組版規則に従います。引用符は自動的に「 」と『 』になります。

段落は一字下げで始まり、行は両端揃えになります。和文と欧文の間には自動的に四分アキが挿入されます（Typst の `cjk-latin-spacing` 機能）。

== このテンプレートの構成

- B5 判（182mm × 257mm）のページ
- 本文 10pt、行送りは和文標準の空き
- のど側と地側に広い余白（製本込みのレイアウト）
- 下中央のノンブル（ページ番号）

== 主な要素の書き方

箇条書きや番号付きリストも使えます。

+ 番号付きリストの項目
+ 番号付きリストの項目

コードは等幅フォント（Source Han Mono）で表示され、日本語のコメントもそのまま書けます。

```typst
// 日本語コメントも等幅フォントで表示される
#let greeting = "こんにちは"
#greeting
```

== 章の追加

見出しを `=` で書くと「第N章」として採番され、新しいページから始まります。`==` は節（1.1）、`===` は項（1.1.1）です。

= サンプル章

これが第2章の冒頭です。章見出しはゴシック体（Noto Sans CJK JP）で表示されます。

== 数式のサンプル

Typst の数式も日本語文書の中でそのまま使えます。たとえば二次方程式の解は $x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a)$ となります。

== 注釈

脚注も使えます#footnote[これは脚注のサンプルです。]。
