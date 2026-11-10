#let chapters = (
  "readme.typ",
  "raw.typ",
  "code.typ",
)

#chapters.map(c => include "appendix/" + c).join()

