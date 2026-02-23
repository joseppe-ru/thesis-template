#import "../meta.typ": meta
#import "@preview/hydra:0.6.2": hydra
#let layout(body) = {
  set document(title: meta.title, author: meta.author)
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
  //
  // --- Typografie ---
  let body-font = "Times New Roman"
  set text(font: body-font, size: 12pt, lang: "de")
  set par(justify: true, leading: 1em, linebreaks: "optimized")
  show math.equation: set text(weight: 400)

  // --- Überschriften (Headings) ---
  set heading(numbering: "1.1", supplement: [Kapitel])
  show heading: set block(below: 1.4em, above: 1.75em)

  // Überschriften im Verzeichnis
  show outline.entry.where(
    level: 1,
  ): it => {
    v(1em, weak: true) // Macht einen kleinen Abstand vor Hauptkapiteln (DIN-konform!)
    strong(it) // Macht den gesamten Eintrag inkl. Seitenzahl fett
  }

  // Abstände zwischen Nummerierung und Text
  show heading.where(numbering: "1.1"): it => block({
    let w = if it.level == 1 { 25pt } else { 30pt }
    box(width: w, counter(heading).display())
    it.body
  })

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "semibold")
    it
  }
  show heading.where(level: 2): set text(size: 14pt, weight: "semibold")
  show heading.where(level: 3): set text(size: 12pt, weight: "semibold")
  show heading.where(level: 4): set text(size: 12pt, weight: "regular", style: "italic")
  body
}
