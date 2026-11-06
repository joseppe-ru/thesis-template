#import "meta.typ": meta
#import "@preview/hydra:0.6.2": hydra

// #let layout(body) = {
//
//   // --- Metadaten ---
//   // =================
//   set document(title: meta.title, author: meta.author)
//
//
//   // --- Seitenlayout ---
//   // ====================
//   set page(
//     paper: "a4",
//     margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 2cm),
//     header-ascent: 1.25cm,
//     footer-descent: 1.25cm, 
//     numbering: "I",
//     number-align: right,
//     header: context {
//       set text(size: 10pt,bottom-edge: "descender") // Kopfzeile 10 Pkt.
//       block[
//         #hydra(1)
//         #line(length: 100%, stroke: 0.5pt + black) // Waagerechter Strich
//       ]
//     },
//     footer: context {
//       set text(size: 12pt)
//       set align(right)
//       counter(page).display(page.numbering)
//     }
//   )
//
//
//   // --- Typografie ---
//   // ==================
//   let body-font = "Times New Roman"
//   set text(font: body-font, size: 12pt, lang: "de", top-edge: 1em, bottom-edge: 0em,)
//   set par(justify: true, linebreaks: "optimized",  leading: 0.15em,spacing: 1.17em,)
//
//
//   // --- Inhaltsverzeichnis ---
//   // ==========================
//   show outline.entry.where(level: 1): it => {
//     v(1em, weak: true) 
//     strong(it)
//   }
//
//
//   // --- Überschriften --- 
//   // =====================
//   // Allgemeine Überschriftenabstände
//   show heading: set block(
//     above: 28pt,
//     below: 14pt,
//   )
//
//   // Ebene 1 beginnt auf neuer Seite
//   show heading.where(level: 1): set block(
//     above: 0pt,
//     below: 14pt,
//   )
//
//   set heading(numbering: "1.1", supplement: [Kapitel])
//   // Ebene 1
//   show heading.where(level: 1): it => {
//     pagebreak(weak: true)
//     set text(size: 16pt, weight: "bold")
//     it
//   }
//   // Ebene 2
//   show heading.where(level: 2): it => {
//     set text(size: 14pt, weight: "bold")
//     it
//   }
//   // Ebene 3
//   show heading.where(level: 3): it => {
//     set text(size: 12pt, weight: "bold")
//     it
//   }
//   // Ebene 4
//   show heading.where(level: 4): it => {
//     set text(size: 12pt, weight: "regular", style: "italic")
//     it
//   }
//
//
//   // --- Referenzen ---
//   // ==================
//   show ref: it => {
//     let label-str = str(it.target)
//     if (
//       label-str.starts-with("fig:")
//         or label-str.starts-with("tab:")
//         or label-str.starts-with("appendix:")
//         or label-str.starts-with("kap:")
//     ) {
//       strong(it)
//     } else {
//       it
//     }
//   }
//
//
//   // --- Tabellen und Bilder ---
//   // ===========================
//   // => Abbildungen
//   show figure.caption: set text(size: 10pt)
//   show figure.caption: set align(left)
//   show figure.where(kind: image): set figure(supplement: [Abbildung])
//   show figure.where(kind: image): it => {
//     set block(above: 1.2em, below: 1.2em)
//     it
//   }
//   // => Tabellen
//   show figure.where(kind: table): set figure.caption(position: top)
//   show figure.where(kind: table): set figure(supplement: [Tabelle])
//     set table(
//       fill: (x, y) => if y == 0 { rgb("BDC1D0") },
//       inset: (right: 1.5em),
//     )
//     show table.cell: it => {
//       if it.y == 0 {
//         set text(black)
//         strong(it)
//       } else if it.body == [] {
//         pad(..it.inset)[_N/A_]
//       } else {
//         it
//       }
//     }
//   // Rahmen zeichnen
//   show figure.where(kind: image): fittich => {
//     set figure(gap: 0pt)
//     block[
//       #rect(stroke: 1pt, inset: 1pt)[#fittich.body]
//       #v(-1em)
//       #fittich.caption
//     ]
//   }
//
//   // --- Gleichungen ---
//   // ===================
//   set math.equation(numbering: "(1)")
//   show math.equation: set block(above: 1.2em, below: 1.2em)
//   show math.equation: set text(weight: 400)
//
//   body
// }
//



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

  // Metadaten
  // =========
  set document(
    title: meta.title,
    author: meta.author,
  )

  // Seitenlayout
  // ============
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3cm,
      left: 4cm,
      right: 2cm,
    ),
    header-ascent: 1.25cm,
    footer-descent: 1.25cm,

    numbering: none,

    header: context {
      set text(
        size: 10pt,
        bottom-edge: "descender",
      )
      stack(
        dir: ttb,
        spacing: 3pt,
        hydra(1),
        line(
          length: 100%,
          stroke: 0.5pt + black,
        ),
      )
    },
    footer: thesis-footer(format: none),
  )

  // Typografie
  // ==========
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "de",
  )

  // Fließtext
  // =========
  set par(
    justify: true,
    leading: 0pt,
    spacing: 12pt,
    linebreaks: "optimized",
  )

  // Inhaltsverzeichnis
  // ==================
  show outline.entry.where(level: 1): it => {
    v(1em, weak: true)
    strong(it)
  }

  // Überschriften
  // =============
  set heading(
    numbering: "1.1",
    supplement: [Kapitel],
  )
  show heading: set block(
    above: 24pt,
    below: 12pt,
  )
  // Ebene 1 anders
  show heading.where(level: 1): set block(
    above: 0pt,
    below: 12pt,
  )
  // Ebene 1
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(
      size: 16pt,
      weight: "bold",
    )
    it
  }
  // Ebene 2
  show heading.where(level: 2): set text(
    size: 14pt,
    weight: "bold",
  )
  // Ebene 3
  show heading.where(level: 3): set text(
    size: 12pt,
    weight: "bold",
  )
  // Ebene 4
  show heading.where(level: 4): set text(
    size: 12pt,
    weight: "regular",
    style: "italic",
  )

  // Referenzen
  // ==========
  show ref: it => {
    let label-str = str(it.target)
    if (
      label-str.starts-with("fig:")
      or label-str.starts-with("tab:")
      or label-str.starts-with("appendix:")
      or label-str.starts-with("kap:")
    ) {
      strong(it)
    } else {
      it
    }
  }


  // Abbildungen und Tabellen
  // ========================
  // Gemeinsame Beschriftung:
  show figure.caption: set text(size: 10pt)
  show figure.caption: set align(left)
  show figure.caption: set par(
    justify: false,
    leading: 0pt,
    spacing: 0pt,
    hanging-indent: 1em,
  )
  // Abbildungen
  show figure.where(kind: image): set figure(
    supplement: [Abbildung],
  )
  show figure.where(kind: image): set block(
    above: 12pt,
    below: 12pt,
  )

  // Tabellen
  show figure.where(kind: table): set figure(
    supplement: [Tabelle],
    // caption: figure.caption(
    //   position: top,
    // ),
  )
  show figure.where(kind: table): set block(
    above: 12pt,
    below: 12pt,
  )


  // Tabellenformatierung
  // ====================

  set table(
    fill: (x, y) => {
      if y == 0 {
        rgb("BDC1D0")
      }
    },
    inset: 4pt,
  )
  show table.cell: it => {
    set text(size: 10pt)

    set par(
      leading: 0pt,
      spacing: 0pt,
    )

    if it.y == 0 {
      strong(it)
    } else if it.body == [] {
      pad(..it.inset)[_N/A_]
    } else {
      it
    }
  }

  // Gleichungen
  // ===========
  set math.equation(
    numbering: "(1)",
  )
  show math.equation: set block(
    above: 12pt,
    below: 12pt,
  )
  show math.equation: set text(
    weight: 400,
  )

  body
}

