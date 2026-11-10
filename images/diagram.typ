#import "@preview/lilaq:0.6.0" as lq
#import "../utils/lib.typ":*

#let (x, y) = lq.load-txt(read("data.csv"))

#figure(
  kind: image,
  caption: [CSV-Plot mit `lilaq`],

lq.diagram(
  lq.plot(x, y),
)
) <dia:csv>
