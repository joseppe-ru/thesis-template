#import "../utils/lib.typ":*

= Template <kap:Temp>
== Allgemein <kap:allg>
Das Dokument dient als Showcase um Formatierungen von Typst darzubieten und zu feinjustieren, bis sie den ansprüchen der #short("HTW") Dresden genügen. Die gesamte Formatierung entspricht den offiziellenen Richtlinen für das Anfertigen wissenschaftlicher Arbeiten nach dem Dokument von #imtext(<schulzeAbschlussarbeiten>) der fakultät Informatik der und ist in der Datei `layout.typ` programmiert.
Die einzige Ausnahme bildet die Regel, dass nach einem Kapiel zwei leerzeilen platz gelassen werden muss. Dieser Abstand muss zusätzlich eingefügt werden, da ich dafür keine allgemeine Regel definieren konnte (`#v(12pt)`).

Alle anderen eigenheiten und die Strucktur dieses Projektes befindet sind in @appendix:readme.

Im allgemeinen ist zu sagen, dass sich Typst beim schreiben des Fließtextes vorwiegend wie Markdown anfühlen soll. Das Layout des gesamten Dokumentes wird über Funktionen bestimmt, welche die Standardwerte der von Typst generierten Objekte überschreiben können. 

#v(12pt)
== Textformatierung <kap:tab>

Die @tab:text führt ein paar Formatierungsmöglichkeiten auf. Für maches benutze ich eigene Funktionen aus dem Unterordner `utils/`. 

#fmt_table(kind: tbl.normal, caption:"Fließtext Formatierungshinweise", columns:(1fr,1fr,1fr), ..(
  "Object", "Raw", "Display",
  "Heading",`=/==/=== Kapitel`, "1.1.1 Kapitel",
  "Acronyme", `#short("TUD")`, short("TUD"),
  [Zitat],`@SPIXSPIHow`,[@SPIXSPIHow],
  "Querverweis",`@kap:Temp`,[@kap:Temp],
  "Fett",`*Fett*`,[*Fett*],
  "Kursiv", `_kursiv_`,[_kursiv_], 
  "Debug Typst",`panic(repr(fkk.fields()))`, ".!.!.! > Console",
))<tab:text>

#v(12pt)
== Mathe <kap:mathe>
Mathematische Funktionen können umschlossen von 2 Dollerzeichen (`$..$`) geschreiben werden. 

`$ F = m dot a = 12 "N" $`, 

$ F = m dot a = 12 "N" $ <eq:kraft>

Referenz auf die newtoische Gleichung der Kraft in @eq:kraft.


#v(12pt)
== Zitate
=== Im laufenden Satz
Der vorgeschriebene Zitierstil weicht doch etwas von "apa" oder aderen ab. Daher ist dieser auch fest in einer `cite-styl.cls` Datei festgehalten. Diese wurde erstellt von #imtext(<googlegemini>).

#v(12pt)
=== Direktes Zitat
"Generic and generative methods are used whenever possible. These principles lead to an understandable, maintainable, efficient, and provably correct system." #zitat(<ferdinandReliablePreciseWCET2001a>).

#v(12pt)
=== Indirektes Zitat
So steht der Text da gar nicht drin. #vgl(<abelNanoBenchLowOverheadTool2020a>,s:"5")


#v(12pt)
== Bild <kap:bild>
=== Diagramm <kap:dia>
Für (UML)-Diagramme und jede andere Art von Plots gibt es sehr viele community-Module. Diese findet man unter: https://typst.app/universe/search/?q=uml

Für den Plot von @dia:csv wurde `lilaq` verwendet, welches Die Datenpunkte aus einer `CSV`-Datei ausließt.

#include "../images/diagram.typ"

#v(12pt)
=== Picture <kap:picture>
Ebenso lassen sich Bilder unteranderem im #short("PNG"), #short("JPEG") oder #short("SVG") Format einbinden, wie unter @fig:meme veranschaulicht wird. 


#figure(
  box(stroke:0.5pt+black,
    inset: 2pt,
    image("../images/programmerhumor.jpeg", height: 50%)), 
  caption: [ein Informatiker Witzbild]
)<fig:meme>

Bei solchen Bilder wie @fig:meme ist es machnal wichtig für die Darstellung, einen seperaten rand zu haben, wie in diesem Fall mit `box` gezeichnet.

#v(12pt)
== Stichpunke
Eine Stichpunktliste ist sehr einfach gehandhabt. Man verwedet ein Minus "-" im Fließtext.

Normal list.
- Text
- Math
- Layout
- ...

Function call.
#list(
  [Foundations],
  [Calculate],
  [Construct],
  [Data Loading],
)


#v(12pt)
== Aufzählung
Mit Plus "+", oder Zahl "1." oder Funktion "`#enum[][][]`"

Automatically numbered:
+ Preparations
+ Analysis
+ Conclusions

Manually numbered:
2. What is the first step?
5. I am confused.
+  Moving on ...



Function call.
#enum[First][Second]

#v(12pt)
= Viel Text mit Absätzen
#lorem(100)

#lorem(50)

#lorem(200)

#lorem(10)

#v(12pt)
= Text mit Unterpunkten
== Unterpunkt
#lorem(130)
#v(12pt)
== Runder Punkt
=== Runder Punkt Unterpunkt
#lorem(220)
#v(12pt)
=== Runder Punkt, wunder Punkt
#lorem(100)
#v(12pt)
== Kunterbunt
#lorem(50)

