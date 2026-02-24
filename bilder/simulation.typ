#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "../utils.typ": *

#let wide = 35mm
#figure(
  diagram(
    spacing: (0cm, 1cm),

    blob((0, 0), [Pumpe], width: wide, height: 20mm, name: <bp>),
    blob((1, 0), [Rohr/Abgasleitung], width: 60mm, name: <br>),
    blob((2, 0), [Abatementsystem], width: wide, height: 20mm, name: <ba>),
    edge(<ba>, <bp>, shift: -20pt, "<-", label: "Flussrichtung", label-side: right),
    edge(<bp>, <pdat>, "->", stroke: (dash: "dashed")),
    edge(<ba>, <adat>, "->", stroke: (dash: "dashed")),
    edge(<br>, <rdat>, "->", stroke: (dash: "dashed")),
    node(
      width: wide,
      (0, 1),
      text(style: "italic", size: 10pt)[defekt,   Fremdkörper, verklemmt, Verschleiß, Verschlakung],
      name: <pdat>,
    ),
    node((2, 1), text(style: "italic", size: 10pt)[defekt, inaktiv], name: <adat>),
    node((1, 1), text(style: "italic", size: 10pt)[Leck, undicht, Verstopfung, Korrosion], name: <rdat>),
  ),
  caption: [Modellierung Pumpen-Abatement-System],
)

<fig:pumpenAbatementModell>
