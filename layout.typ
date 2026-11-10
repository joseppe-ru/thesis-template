#import "meta.typ": meta
#import "@preview/hydra:0.6.2": hydra

// Seitenzahlen / Fußzeile
// =======================
#let thesis-footer(format: none) = context {
  set text(size: 12pt)

  stack(
    dir: ttb,
    spacing: 2pt,

    line(length: 100%, stroke: 0.5pt + black),

    align(right)[
      #if format != none {
        counter(page).display(format)
      }
    ],
  )
}

#let layout(body) = {

  // --- Metadaten ---
  // =================
  set document(title: meta.title, author: meta.author)


  // --- Seitenlayout ---
  // ====================
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 2cm),
    header-ascent: 1.25cm,
    footer-descent: 1.25cm, 
    numbering: none,
    number-align: right,
    header: context {
      set text(size: 10pt,bottom-edge: "descender") 
      block[
        #hydra(1)
        #line(length: 100%, stroke: 0.5pt + black) 
      ]
    },
    footer: thesis-footer(format: none),
  )


  // --- Typografie ---
  // ==================
  let body-font = "Times New Roman"
  set text(font: body-font, size: 12pt, lang: "de", top-edge: 1em, bottom-edge: 0em,)
  set par(justify: true, linebreaks: "optimized",  leading: 2pt,spacing: 14pt,)


  // --- Inhaltsverzeichnis ---
  // ==========================
  show outline.entry.where(level: 1): it => {
    v(0.6em, weak: true) 
    strong(it)
  }


  // --- Überschriften --- 
  // =====================
  // Allgemeine Überschriftenabstände
  show heading: set block(
    above: 14pt,
    below: 14pt,
  )

  // Ebene 1 beginnt auf neuer Seite
  show heading.where(level: 1): set block(
    above: 0pt,
    below: 14pt,
  )

  set heading(numbering: "1.1", supplement: [Kapitel])
  // Ebene 1
  show heading.where(level: 1): it => {
    // Ausnahme für Cover
    if not it.has("label") or it.label != <no-break> {
      pagebreak(weak: true)
      set text(size: 16pt, weight: "bold")
    } else {
      set text(size: 2em, weight: 700)
    }
    it
  }

  // Ebene 2
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    it
  }
  // Ebene 3
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    it
  }
  // Ebene 4
  show heading.where(level: 4): it => {
    set text(size: 12pt, weight: "regular", style: "italic")
    it
  }


  // --- Referenzen ---
  // ==================
  show ref: it => {
    let label-str = str(it.target)
    if (
      label-str.starts-with("fig:")
        or label-str.starts-with("tab:")
        or label-str.starts-with("appendix:")
        or label-str.starts-with("kap:")
        or label-str.starts-with("eq:")
        or label-str.starts-with("dia:")
    ) {
      strong(it)
    } else {
      it
    }
  }


  // --- Tabellen und Bilder ---
  // ===========================
  show figure.caption: set align(left)
  show figure.caption: it => {
    block( 
      // width:100%, // Das hier setzt den Caption anfang auf den linken rand der Seite
      par(
      hanging-indent: 1em, 
      strong(it.supplement + [ ] + context it.counter.display(it.numbering)+[: ]) + it.body))
  }

  show figure.caption: set text(size:10pt)

  // => Abbildungen
  show figure.where(kind: image): set figure(supplement: [Abbildung], numbering: "1.1")
  show figure.where(kind: image): it => {
    set block(above: 1.2em, below: 1.2em)

    // box(
    //   stroke:0.5pt+black,
    //   inset: 2pt,
    //   it.body
    // )
    // it.caption
    it
  }

  // => Tabellen
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Tabelle])
  show figure.where(kind: table): set text(size:10pt)
  show figure.where(kind: table): set par(leading: 0.5em, hanging-indent: 12pt, justify:false)




  // --- Gleichungen ---
  // ===================
  set math.equation(
    numbering: "(1)",
    number-align:right
  )
  show math.equation.where(block: true): set block(
    above: 1.2em,
    below: 1.2em,
  )
  show math.equation: set text(weight: 400, size:10pt)



body
}




