#let chapters = (
  "einleitung.typ",
  "grundlagen.typ",
  "konzeption.typ",
  "implementierung.typ",
  "testundergebnisse.typ",
  "fazitundausblick.typ",
)

#chapters.map(c => include "content/" + c).join()
