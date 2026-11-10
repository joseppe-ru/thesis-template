#import "@preview/acrostiche:0.7.0": * // Modul  für Abkürzungen
#import "meta.typ": acronyms, meta
#import "layout.typ": layout, thesis-footer

#show: layout

// === Formblätter
#set heading(numbering: none, outlined: false, bookmarked: true)

// Deckblatt
#include "cover.typ"
#counter(figure.where(kind: table)).update(0)

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
#v(1em)
#outline(title: none)

#set heading(outlined:true)
= Abbildungsverzeichnis
#v(1em)
#outline(title:none, target: figure.where(kind: image))

= Tabellenverzeichnis
#v(1em)
#outline(title:none, target: figure.where(kind: table))

= Abkürzungsverzeichnis
#v(1em)
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
#v(1em)
#bibliography("literatur.bib", style: "cite-styl.cls", title:none)


// === Anhang
#set heading(numbering: "A.1", supplement: [Anhang])
#counter(heading).update(0)

#include "anhang.typ"

