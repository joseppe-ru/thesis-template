#import "@preview/acrostiche:0.7.0": *

= Konzeption
<konzeption>
== Zielarchitektur: Modellierung einer Subfab mittels AAS
<zielarchitektur-modellierung-einer-subfab-mittels-aas>
Die Grundlage für den souveränen und standardisierten Austausch von
Equipmentdaten bildet eine konzeptionelle Zielarchitektur, welche die
informationstechnische Kapselung der physischen Assets und deren
kontrollierte Freigabe in einem unternehmensübergreifenden Datenraum
beschreibt. Diese Architektur, dargestellt in #strong[Abbildung
  @fig:ZielSys];, gliedert das Gesamtsystem in drei logische Domänen, die
den Informationsfluss vom Entstehungsort der Daten bis zu ihrer finalen
Verwertung abbilden

#figure(image("../bilder/gesamtsystem.png", width: 80%), caption: [
  Zielarchitektur der Datenpipeline vom Asset zum Client
])
<fig:ZielSys>

Der Prozess hat seinen Ursprung in der Domäne des Datenanbieters, in
diesem Kontext der Halbleiterfabrik. Hier werden die physikalischen
Assets – die Vakuumpumpe und das Abatement-System – durch eine
datengenerierende Simulation repräsentiert, welche die prozessrelevanten
Druckwerte dynamisch erzeugt. Diese Livedaten werden in eine
servicebasierte Laufzeitumgebung überführt, die für die Verwaltung der
standardisierten Digitalen Zwillinge zuständig ist.

Eine solche Umgebung stellt die Kernfunktionalitäten wie einen Speicher
der AAS-Instanzen und ihrer Teilmodelle sowie Services, die das
Auffinden dieser Verwaltungsschalen im Netzwerk des Anbieters
ermöglicht.

Die informationstechnische Brücke zu externen Partnern wird durch die
Domäne des Datenraums geschlagen. Für die Realisierung dieses souveränen
Datenaustauschs betreiben beide Geschäftspartner eine Instanz eines
Konnektors, wie ihn beispielsweise der Eclipse Dataspace Connector (EDC)
darstellt. Dessen Architektur sieht eine strikte Trennung von Kontroll-
und Datenebene vor. Auf der Kontrollebene (EDC-Auth) werden zunächst die
Zugriffs- und Nutzungsbedingungen in Form von maschinenlesbaren Policies
ausgehandelt. Erst nach einem erfolgreichen Abschluss dieses digitalen
Vertrags wird die Datenebene (EDC-Data) aktiviert, um den eigentlichen
Transfer der Verwaltungsschale sicher und gemäß der zuvor vereinbarten
Richtlinien durchzuführen.

In der Domäne des Datennutzers, dem Equipmenthersteller, empfängt
schlussendlich eine anwenderspezifische #strong[Client-Anwendung] die
autorisierten AAS-Daten. Diese Applikation ist für die nachgelagerte,
fachliche Analyse der übermittelten Informationen zuständig, um aus den
Druckwerten wertvolle Erkenntnisse für die prädiktive Wartung zu
gewinnen und entsprechende Handlungsempfehlungen abzuleiten. Diese
architektonische Trennung gewährleistet auf konzeptioneller Ebene, dass
die Halbleiterfabrik die volle Souveränität über ihre Daten behält,
während der Equipmenthersteller auf standardisierte und autorisierte
Weise auf die für ihn relevanten Informationen zugreifen kann.

== Herleitung des Simulationsansatzes
<herleitung-des-simulationsansatzes>
Die Implementierung einer prädiktiven Wartungsstrategie basiert
fundamental auf der Analyse von Daten, die den \"Gesundheitszustand\"
eines Systems widerspiegeln. Im betrachteten Anwendungsfall der
Halbleiter-Sub-Fab ist die Effizienz des Abgastransports von der
Prozesskammer zum Abatement-System von kritischer Bedeutung. Dieses
System (vgl. #strong[Abbildung @fig:pumpenAbatementModell];), bestehend
aus Pumpe, Rohrleitung und Abatement-System, bildet eine physikalisch
gekoppelte Einheit, deren Zustand maßgeblich durch die herrschenden
Druckverhältnisse bestimmt wird. Eine Abweichung der Druckdifferenz
zwischen dem Pumpenausgang und dem Abatement-Eingang von einem
definierten optimalen Betriebszustand ist ein starker Indikator für eine
beginnende Anomalie.

#figure(image("../bilder/pumpe-abatement-schema.png", width: 80%), caption: [
  Modellierung Pumpen-Abatement-Abgassystem
])
<fig:pumpenAbatementModell>

Da in der realen Produktionsumgebung keine Livedaten zur Verfügung
stehen und das gezielte Herbeiführen von Fehlfunktionen für Testzwecke
ausgeschlossen ist, ist die #strong[Simulation] der physikalischen
Prozesse die einzig gangbare Methode, um eine validierte Datengrundlage
zu schaffen. Eine solche Simulation ermöglicht es, kontrolliert und
reproduzierbar Daten für eine Vielzahl von Betriebs- und Fehlerszenarien
zu generieren. Diese Daten sind unerlässlich, um später KI-gestützte
Modelle zur Anomalieerkennung zu trainieren und zu validieren. Die zu
entwickelnde Simulation muss das dynamische Verhalten des gesamten
Abgaspfades realitätsnah abbilden. Kernanforderung ist die Generierung
der beiden zentralen Messgrößen, dem Ist-Druck am Ausgang der Pumpe und
dem Ist-Druck am Eingang des Abatements.

Basierend auf den physikalischen Gegebenheiten und möglichen
Fehlerquellen, die in #strong[Abbildung @fig:pumpenAbatementModell]
skizziert sind, lassen sich verschiedene Wartungsszenarien ableiten, die
von der Simulation abgebildet werden müssen. Dazu gehören der optimale
Normalbetrieb, eine allmähliche Rohrverschmutzung, eine plötzliche
Verstopfung, diverse Formen des Pumpenverschleißes oder -defekts sowie
Leckagen im System. Die Korrelationen zwischen den Druckverhältnissen
und den daraus resultierenden Fehlerbildern lassen sich systematisch in
einer Matrix zusammenfassen, wie sie in #strong[Tabelle
  @tab:druckverhaeltnisse] dargestellt ist.

#figure(
  align(center)[#table(
    columns: 5,
    align: (left, left, left, left, left),
    table.header(
      [$p_(i s t)^(P u m p e) / p_(i s t)^(A b a t e m e n t)$],
      [über
        Toleranzwert],
      [innerhalb Toleranzwert],
      [unterhalb
        Toleranzwert],
      [kein Druck / Negativdruck],
    ),
    table.hline(),
    [über
      Toleranzwert],
    [Verstopfung],
    [Abatement-Rückstau],
    [Abatement-Rückstau
      & Pumpenfehler],
    [Pumpenausfall mit Rückstau],
    [innerhalb Toleranzwert],
    [Verschmutzung],
    [Optimaler
      Betrieb],
    [Leckage / Pumpenfehler],
    [Rohrbruch],
    [unterhalb Toleranzwert],
    [Rohr verstopft],
    [Leckage],
    [Pumpendefekt
      \/ Verschleiß],
    [Systemfehler / Inaktivität],
    [kein Druck / Negativdruck],
    [Vollständiger
      Rohrverschluss],
    [Sensorfehler],
    [Pumpendefekt (Kein Druck)],
    [Pumpe
      inaktiv / Verklemmt],
  )],
  caption: [Matrix über Druckverhältnisse und mögliche Szenarien],
  kind: table,
)<tab:druckverhaeltnisse>
Aus dieser Systematik werden zentrale wissenschaftliche Hypothesen
abgeleitet, welche die Simulationsdaten verifizieren sollen. Es wird
postuliert, dass ein schleichender Anstieg der Druckdifferenz zwischen
den beiden Messpunkten bei gleichzeitig erhöhtem Druck am Pumpenausgang
auf eine progressive Rohrverschmutzung hindeutet. Im Gegensatz dazu wird
ein simultaner Druckabfall an beiden Punkten unter den Sollwert als
Indikator für einen fortschreitenden Pumpenverschleiß oder einen akuten
Defekt angenommen. Eine weitere Hypothese besagt, dass ein signifikanter
Druckabfall am Abatement bei gleichzeitig nur leicht verändertem Druck
an der Pumpe auf eine Leckage zwischen den beiden Messpunkten hinweist.
Die Simulation muss daher so konzipiert sein, dass sie genau diese
Muster erzeugen kann. Die generierten Zeitreihendaten für die in
#strong[Tabelle @tab:use_cases_simulation] aufgeführten Szenarien bilden
die Grundlage, um Algorithmen zu entwickeln, die eine Klassifizierung
dieser unterschiedlichen Fehlerbilder ermöglichen und somit eine
gezielte Wartungsempfehlung ableiten können.

#figure(
  align(center)[#table(
    columns: 5,
    align: (left, left, left, left, left),
    table.header(
      [Use-Case],
      [Druck Pumpe \[mBar\]],
      [Druck Abatement
        \[mBar\]],
      [Pumpe Toleranz],
      [Abatement Toleranz],
    ),
    table.hline(),
    [Verstopfung], [130], [130], [über], [über],
    [Abatement-Rückstau], [110], [130], [innerhalb], [über],
    [Abatement-Rückstau & Pumpenfehler], [70], [130], [unter], [über],
    [Pumpenausfall mit Rückstau], [0], [130], [kein], [über],
    [Verschmutzung], [130], [110], [über], [innerhalb],
    [Optimaler Betrieb], [100], [100], [innerhalb], [innerhalb],
    [Leckage / Pumpenfehler], [70], [100], [unter], [innerhalb],
    [Rohrbruch], [0], [100], [kein], [innerhalb],
    [Rohr verstopft], [130], [70], [über], [unter],
    [Leckage], [110], [70], [innerhalb], [unter],
    [Pumpendefekt / Verschleiß], [70], [70], [unter], [unter],
    [Systemfehler / Inaktivität], [0], [70], [kein], [unter],
    [Vollständiger Rohrverschluss], [130], [0], [über], [kein],
    [Sensorfehler], [100], [0], [innerhalb], [kein],
    [Pumpendefekt (Kein Druck)], [70], [0], [unter], [kein],
    [Pumpe inaktiv / Verklemmt], [0], [0], [kein], [kein],
  )],
  caption: [Use-Cases für die Simulation],
  kind: table,
)

<tab:use_cases_simulation>
== Auswahl des Implementierungs-Frameworks: Eclipse BaSyx
<auswahl-des-implementierungs-frameworks-eclipse-basyx>
Um die Konzepte der Verwaltungsschale praktisch umzusetzen, bedarf es
einer Middleware, die eine standardkonforme Realisierung der Digitalen
Zwillinge sowie der notwendigen Infrastrukturdienste ermöglicht. Im
Rahmen dieser Arbeit fiel die Wahl auf #strong[Eclipse BaSyx];, da es
sich hierbei um eine der ersten und zugleich die offizielle
Open-Source-Referenzimplementierung für die Verwaltungsschale handelt,
die unter dem Dach der Eclipse Foundation entwickelt wird. @EclipseBasyx

Das Projekt wird maßgeblich vom #acr("IESE") koordiniert und von einem breiten
Netzwerk aus Industrie- und Forschungspartnern unterstützt und genutzt.
@EclipseBasyxAbout

Die Entscheidung für dieses Framework gründet sich auf mehreren
zentralen Vorteilen. Als Referenzimplementierung stellt es eine hohe
Konformität mit den aktuellen Spezifikationen der IDTA sicher. Die
Bereitstellung als Open-Source-Software unter einer
industriefreundlichen Lizenz senkt die Einstiegshürden erheblich und
erlaubt auch eine Nutzung im kommerziellen Kontext. @EclipseBasyxProject

Des Weiteren bietet BaSyx SDKs für gängige Programmiersprachen wie Java,
C\# und Python, was eine hohe Flexibilität bei der Anwendungsentwicklung
gewährleistet. @EclipseBasyxGitHub

Eclipse BaSyx stellt eine modulare Middleware zur Verfügung, die alle
notwendigen Komponenten für den Aufbau einer AAS-basierten Infrastruktur
als einzelne, containerisierte Microservices bereitstellt. Diese Dienste
können kombiniert werden, um eine vollständige Laufzeitumgebung für
Digitale Zwillinge zu schaffen. @EclipseBasyxWiki

Der #strong[AAS Server];, oft auch als #strong[Repository] bezeichnet,
ist die Kernkomponente für das Hosting der eigentlichen AAS- und
Teilmodell-Instanzen. Er stellt eine standardisierte API (z.B.
HTTP/REST) bereit, über die auf die Inhalte des Digitalen Zwillings
zugegriffen, diese erstellt, gelesen, aktualisiert oder gelöscht werden
können.

Die #strong[AAS Registry] fungiert als zentrales Verzeichnis oder
\"Telefonbuch\" für die Verwaltungsschalen. Jede AAS-Instanz im System
wird hier mit ihrem eindeutigen Identifikator und dem Netzwerk-Endpunkt
ihres AAS Servers registriert. Anwendungen können die Registry abfragen,
um dynamisch herauszufinden, unter welcher Adresse eine bestimmte
Verwaltungsschale erreichbar ist.

Analog zur AAS Registry dient die #strong[Submodel Registry] der
Registrierung und dem Auffinden von einzelnen Teilmodellen. Dies
unterstützt eine dezentrale Architektur, in der Teilmodelle von
unterschiedlichen Servern bereitgestellt und dynamisch zu einer
Gesamt-AAS aggregiert werden können.

Aufbauend auf den Registries ermöglicht der #strong[Discovery];-Service
eine semantische Suche über den Bestand der Verwaltungsschalen. Anstatt
eine AAS über ihre eindeutige ID zu suchen, können Anwendungen hier
beispielsweise alle Assets abfragen, die über ein bestimmtes Teilmodell
(z.B. \"Technische Daten\") oder eine spezifische Eigenschaft verfügen.

Die #strong[AAS Environment];-Komponente fasst schließlich die
Gesamtheit aller AAS-bezogenen Elemente – also die AAS selbst, ihre
Teilmodelle und die zugehörigen semantischen Definitionen (Concept
Descriptions) – zusammen und stellt sie über eine einzige Schnittstelle
als kohärente Einheit bereit, was insbesondere den Austausch von
vollständigen Digitalen Zwillingen vereinfacht.

Obwohl alternative Open-Source-Implementierungen existieren, die sich
teils durch eine einfachere Inbetriebnahme auszeichnen, wurde Eclipse
BaSyx aufgrund seiner umfassenden Modularität und der vollständigen
Abdeckung des AAS-Standards als überlegen für die in dieser Arbeit
geforderte Realisierung bewertet. Die modulare Architektur von BaSyx
erlaubt es, die einzelnen Infrastrukturkomponenten gezielt aufzusetzen
und deren Zusammenspiel im Kontext des Eclipse Dataspace Connectors
detailliert zu untersuchen, was eine zentrale Anforderung dieser
wissenschaftlichen Arbeit ist.

== Entwurf des AAS-Modells
<entwurf-des-aas-modells>
Die informationstechnische Abbildung des Sub-Fab-Systems erfordert ein
durchdachtes und strukturiertes Modell der beteiligten Assets, das deren
physische und logische Beziehungen widerspiegelt. Der hier verfolgte
Entwurfsansatz basiert auf einer hierarchischen Komposition von
Verwaltungsschalen, die eine #strong[Parent-Child-] Beziehung etabliert.
Dieser Aufbau ermöglicht es, das Gesamtsystem als eine logische Einheit
zu betrachten und gleichzeitig die einzelnen Komponenten als
eigenständige Digitale Zwillinge zu verwalten.

Das Wurzelelement der Modellierung bildet eine übergeordnete
Verwaltungsschale, beispielhaft als "SemiconductorX" bezeichnet. Diese
AAS fungiert als logische Klammer (Parent) für das gesamte zu
betrachtende Abgassystem. Unterhalb dieser Hülle sind die
Verwaltungsschalen für die eigentlichen physischen Komponenten als
untergeordnete Elemente (Children) angesiedelt: die
#strong["IndustrialExhaustPump"] und das #strong["AbatementSystem"];.
Jede dieser beiden Verwaltungsschalen stellt einen eigenständigen
Digitalen Zwilling des jeweiligen Assets dar und wird durch eine Reihe
von #strong[Teilmodellen] beschrieben, welche die verschiedenen Aspekte
des Assets kapseln.

Ein zentrales Ziel dieses Entwurfs ist die Gewährleistung von
Interoperabilität und Standardkonformität. Aus diesem Grund wird, wo
immer möglich, auf die Verwendung von standardisierten
#strong[Teilmodell-Templates]
zurückgegriffen.@AdminShellIOSubmodelTemplates Templates sind
vordefinierte, standardisierte Schemata für Teilmodelle, die deren
Struktur, Elemente und semantische Bedeutung festlegen und somit eine
herstellerübergreifende, einheitliche Beschreibung von Aspekten
ermöglichen. Für die grundlegende Identifikation wird in allen drei
Verwaltungsschalen das etablierte Template #strong["Digital Nameplate"]
verwendet, um wesentliche Hersteller- und Typinformationen
bereitzustellen. Zur Beschreibung der technischen Schnittstellen und
Kommunikationsprotokolle wird für die Pumpe und das Abatement-System das
Teilmodell #strong["TechnicalData"] eingesetzt, welches auf dem
standardisierten Template #strong["Asset Interfaces Description"]
basiert. Dies stellt sicher, dass die Art und Weise, wie auf die Daten
der Assets zugegriffen werden kann, einheitlich und maschinenlesbar
spezifiziert ist.

Den Kern des anwendungsspezifischen Datenmodells bildet jedoch das
eigens für diese Arbeit konzipierte Teilmodell
#strong["OperationalData"];. Da für die Erfassung von Live-Betriebsdaten
kein universelles Standard-Template existiert, das die spezifischen
Anforderungen dieses Anwendungsfalls abdeckt, wird hier ein
domänenspezifisches Modell entworfen. Dieses Teilmodell enthält die für
die prädiktive Wartungsanalyse entscheidenden Eigenschaften. Für die
"IndustrialExhaustPump" ist dies die Eigenschaft
#strong["ActualPressure"];, welche den Ist-Druck an ihrem Ausgang
repräsentiert. Korrespondierend dazu enthält das
"OperationalData"-Teilmodell des "AbatementSystem" ebenfalls eine
Eigenschaft namens #strong["ActualPressure"];, die den Druck an seinem
Eingang abbildet. Die semantische Verknüpfung und der Abgleich genau
dieser beiden Werte bilden die datentechnische Grundlage für die spätere
Analyse von Rohrverschmutzungen und Pumpendefekten.

Die Strucktur der Verwaltungsschale ist in #strong[Anhang
  @appendix:aasx-model] beschrieben. 
