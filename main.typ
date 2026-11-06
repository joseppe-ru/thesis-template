#import "@preview/acrostiche:0.7.0": *

// #import "template.typ": template
#import "meta.typ": acronyms, meta
#import "layout.typ": layout, thesis-footer


// #template(
//   appendix: include "anhang.typ",
//   bib: bibliography("literatur.bib", style: "apa", title: "Literatur"),
// )[
//   #include "inhalt.typ"
// ]

#layout[
  // === Formblätter
  // Deckblatt
  #include "cover.typ"

  // Aufgabenstellung  
  // #include "aufgabenstellung.typ"
  #include "abstract.typ"

  // Ehrenwörtliche Erklärung
  // #include "erklaerung.typ"
  
  #pagebreak(weak: true)
  
  #set page(
    numbering: "I",
    footer: thesis-footer(format: "I"),
  )

  = Inhaltsverzeichnis
  #outline()

  = Abbildungsverzeichnis
  #outline(target: figure.where(kind: image))

  = Tabellenverzeichnis
  #outline(target: figure.where(kind: table))

  = Abkürzungsverzeichnis
  #init-acronyms(acronyms)
  // #include "abkuerzungen.typ"

  // // Abbildungsverzeichnis
  // #heading(numbering: none)[Abbildungsverzeichnis]
  // #outline(
  //   title: none,
  //   target: figure.where(kind: image),
  // )
  // #pagebreak()
  //
  // // Tabellenverzeichnis
  // #heading(numbering: none)[Tabellenverzeichnis]
  // #outline(
  //   title: none,
  //   target: figure.where(kind: table),
  // )
  // #pagebreak()

  // === Inhalt
  #pagebreak(weak: true)
  #set page(
    numbering: "1",
    footer: thesis-footer(format: "1"),
  )
  #counter(page).update(1)

  #include "inhalt.typ"

  = Literaturverzeichnis
  #bibliography("literatur.bib", style: "apa")

  // === Anhang

  #set heading(numbering: "A.1", supplement: [Anhang])
  #counter(heading).update(0)

  #include "anhang.typ"
  }
]
