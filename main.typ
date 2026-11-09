#import "@preview/acrostiche:0.7.0": *

// #import "template.typ": template
#import "meta.typ": acronyms, meta
#import "layout.typ": layout, thesis-footer



#show: layout

#set heading(numbering: none, outlined: false)

// === Formblätter
// Deckblatt
#include "cover.typ"

// Aufgabenstellung / Abstract
#include "abstract.typ"

// Ehrenwörtliche Erklärung
#include "policy.typ"


// === Verzeichnisse
#set page(
  numbering: "I",
  footer: thesis-footer(format: "I"),
)
#counter(page).update(1)

= Inhaltsverzeichnis
#outline(title: none)

#set heading(outlined:true)
= Abbildungsverzeichnis
#outline(title:none, target: figure.where(kind: image))

= Tabellenverzeichnis
#outline(title:none, target: figure.where(kind: table))

= Abkürzungsverzeichnis
#init-acronyms(acronyms)
#print-index(delimiter: "", title: "", clickable: true, outlined: true, used-only: true, row-gutter:1em)

// === Inhalt
#set heading(numbering: "1.1")
#set page(
  numbering: "1",
  footer: thesis-footer(format: "1"),
)
#counter(page).update(1)
#pagebreak(weak: true)

#include "inhalt.typ"

// === Quellen
= Literaturverzeichnis
#bibliography("literatur.bib", style: "apa")

// === Anhang
#set heading(numbering: "A.1", supplement: [Anhang])
#counter(heading).update(0)

#include "anhang.typ"

