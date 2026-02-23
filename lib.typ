#import "@preview/hydra:0.6.2": hydra
#import "@preview/acrostiche:0.7.0": print-index

#import "cover.typ": *

#let style(
  title: "",
  titleGerman: "",
  degree: "",
  faculty: "",
  supervisor: "",
  advisors: (),
  author: "",
  bibNumber: "",
  startDate: none,
  submissionDate: none,
  MatrikelNumber: "",
  body,
) = {
  // --- Metadaten & Seitenlayout ---
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 2cm),
    numbering: "I",
    number-align: right,
    header: context {
      // set align(right)
      // set text(style: "italic")
      // hydra(fallback-next: true, top-margin: 3cm)
      hydra(1)
      // v(-8pt)
      line(length: 100%, stroke: 0.5pt + black)
    },
  )

  // --- Typografie ---
  let body-font = "Times New Roman"
  set text(font: body-font, size: 12pt, lang: "de")
  set par(justify: true, leading: 1em, linebreaks: "optimized")
  show math.equation: set text(weight: 400)

  // --- Überschriften (Headings) ---
  set heading(numbering: "1.1", supplement: [Kapitel])
  show heading: set block(below: 1.4em, above: 1.75em)

  // Abstände zwischen Nummerierung und Text
  show heading.where(numbering: "1.1"): it => block({
    let w = if it.level == 1 { 25pt } else { 30pt }
    box(width: w, counter(heading).display())
    it.body
  })

  // Styling der Ebenen & automatischer Seitenumbruch für Ebene 1
  show heading.where(level: 1): it => {
    pagebreak(weak: true) // weak: true verhindert doppelte Leerseiten
    set text(size: 16pt, weight: "semibold")
    it
  }
  show heading.where(level: 2): set text(size: 14pt, weight: "semibold")
  show heading.where(level: 3): set text(size: 12pt, weight: "semibold")
  show heading.where(level: 4): set text(size: 12pt, weight: "regular", style: "italic")

  // --- Cover ---
  cover(
    title: title,
    titleGerman: titleGerman,
    degree: degree,
    faculty: faculty,
    supervisor: supervisor,
    advisors: advisors,
    author: author,
    bibNumber: bibNumber,
    submissionDate,
    MatrikelNumber,
  )
  // --- Verzeichnisse ---

  // Inhaltsverzeichnis: Level 1 fett und ohne Punkte (fill: none)
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set text(weight: "bold")

  outline(
    title: "Inhaltsverzeichnis",
    //fill: repeat([.] + h(0.5em)),
    indent: auto,
  )

  // Abkürzungsverzeichnis (mit modernem 'context' statt 'locate')
  pagebreak()
  // print-index(title: "Abkürzungsverzeichnis", delimiter: "-")
  // pagebreak()
  // heading(numbering: none)[Abkürzungsverzeichnis]
  // context {
  //   let active-acronyms = usedAcronyms.final().pairs().filter(x => x.last()).map(pair => pair.first()).sorted()
  //
  //   for key in active-acronyms {
  //     grid(
  //       columns: (auto, auto, auto),
  //       gutter: 0em,
  //       strong(key), repeat([.]), acronyms.at(key),
  //     )
  //   }
  // }

  // Abbildungs- und Tabellenverzeichnis
  pagebreak()
  heading(numbering: none)[Abbildungsverzeichnis]
  outline(title: none, target: figure.where(kind: image))

  pagebreak()
  heading(numbering: none)[Tabellenverzeichnis]
  outline(title: none, target: figure.where(kind: table))


  // --- Hauptteil initiieren ---
  set page(numbering: "1")
  counter(page).update(1)


  body


  // --- Anhang & Ende ---
  pagebreak()
  heading(numbering: none)[Anhang A: Supplementary Material]
  // include "../common/appendix.typ"

  pagebreak()
  // heading(numbering: none)[Literaturverzeichnis]
  bibliography("literatur.bib", title: "Literaturverzeichnis", style: "ieee")

  // Selbstständigkeitserklärung
  set page(numbering: none)
  heading(numbering: none)[Selbstständigkeitserklärung]
  [Ich versichere, dass ich die Masterarbeit selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.]
  v(3cm)
  table(
    stroke: none,
    inset: 0pt,
    row-gutter: 10pt,
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    rows: 2,
    line(length: 100%), [], line(length: 100%),
    [Datum, Ort], [], [#author],
  )
}

// --- Hilfsfunktionen (Modernisiert) ---

// Typst setzt Anführungszeichen (Smart Quotes) ohnehin automatisch,
// aber wenn du es manuell erzwingen willst:
#let apos(text) = [\"#text\"]

// Native Typst Highlight-Funktion statt manueller Boxen!
#let mark_yellow(body) = highlight(fill: yellow)[#body]
#let mark_green(body) = highlight(fill: green)[#body]
#let mark_red(body) = highlight(fill: red)[#body]

#let placeholder(body) = block(
  fill: yellow,
  width: 100%,
  inset: 5pt,
)[#body]
