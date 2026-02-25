#let chapters = (
  "aas-model.typ",
  "docker-compose-basyx.typ",
  "drucksimulator.typ",
  // "getShells.typ",
  "setup.typ",
  "aascli.typ",
)

#chapters.map(c => include "anhang/" + c).join()

