#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: house
#import "../utils.typ": *



#figure(
  diagram(
    spacing: 1.5cm,

    // blob((1, 0), image("../bilder/pumpe.svg")),
    node((1, 0.02), image("../bilder/pumpe.svg")),
    blob((1, 0.52), [Maschine in Fabrik], width: 25mm),
    edge("<->"),
    blob((2, 0.52), [Datenraum], shape: rect),
    edge("<->"),
    blob((3, 0.52), [Digitaler Zwilling beim Equipmenthersteller], width: 35mm),
    node((3, -0.1), scale(x: -100%)[#image("../bilder/pumpe-reverse.svg")]),
    node((2, 0.4), scale(x: 200%, y: 200%)[#image("../bilder/proxy.svg")]),
  ),
  caption: [Vereinfachte Architektur der Datenübertragung],
)
<fig:ZielSys>
