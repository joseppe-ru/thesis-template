#import "@preview/acrostiche:0.7.0": *

#import "template.typ": *
#import "meta.typ": acronyms, meta


#show: template.with(
  appendix: include "anhang.typ",
  bib: bibliography("literatur.bib", style: "apa", title: "Literatur"),
)


#include "content.typ"

