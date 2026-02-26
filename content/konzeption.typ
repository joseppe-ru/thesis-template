
#import "../utils.typ": *

= Konzeption
<kap:konzeption>
== Zielarchitektur
<kap:zielarchitektur-modellierung-einer-subfab-mittels-aas>
Die Grundlage für den souveränen und standardisierten Austausch von
Equipmentdaten bildet eine konzeptionelle Zielarchitektur, welche die
informationstechnische Kapselung der physischen Assets und deren
kontrollierte Freigabe in einem unternehmensübergreifenden Datenraum
beschreibt. Diese Architektur, dargestellt in @fig:ZielSys, gliedert das Gesamtsystem in drei logische Domänen, die
den Informationsfluss vom Entstehungsort der Daten bis zu ihrer finalen
Verwertung abbilden.


#include "../bilder/pipeline.typ"


Der Prozess hat seinen Ursprung in der Domäne des Datenanbieters, in
diesem Kontext der Halbleiterfabrik. Hier werden die physikalischen
Assets – die Vakuumpumpe und das Abatement-System – durch eine
datengenerierende Simulation repräsentiert, welche die prozessrelevanten
Druckwerte dynamisch erzeugt. (@fig:datenfluss, "Simulation")

Diese Livedaten werden in eine
servicebasierte Laufzeitumgebung überführt, die für die Verwaltung der Digitalen Zwillinge zuständig ist.  (@fig:datenfluss, Nr. 1)

Eine solche Umgebung stellt die Kernfunktionalitäten wie einen Speicher
der #short("AAS")-Instanzen und ihrer Teilmodelle sowie Services, die das
Auffinden dieser Verwaltungsschalen im Netzwerk des Anbieters
ermöglicht. (@fig:datenfluss, "Verwaltungsschale")

Die informationstechnische Brücke zu externen Partnern wird durch die
Domäne des Datenraums geschlagen. Für die Realisierung dieses souveränen
Datenaustauschs betreiben beide Geschäftspartner eine Instanz eines
Konnektors, wie ihn beispielsweise der #short("EDC")
darstellt. (@fig:datenfluss, "Connector Kontroll-/Datenebene")

Dessen Architektur sieht eine strikte Trennung von Kontroll-
und Datenebene vor.
Auf der Kontrollebene werden zunächst die Zugriffs- und Nutzungsbedingungen in Form von Richtlinien erstellt. Dies geschieht auf Seiten der Verwaltungsschale. (@fig:datenfluss, Nr. 2)

Nach dem erstellen eines Assets, im anwendungsfall dieser Ausarbeitung eine REST-Endpoint Datenreferenz, am Connector kann der Client über seinen Connector nach einem Angebotskatalog fragen und einen digitalen Vertrag aushandeln. (@fig:datenfluss, Nr. 3)

Erst nach einem erfolgreichen Abschluss dieses Vertrags wird die Datenebene aktiviert, um den eigentlichen
Transfer der Verwaltungsschale sicher und gemäß der zuvor vereinbarten
Richtlinien durchzuführen. (@fig:datenfluss, Nr. 4 und 5)


In der Domäne des Datennutzers, dem Equipmenthersteller, empfängt
schlussendlich eine anwenderspezifische Client-Anwendung (@fig:datenfluss, "Client") die
autorisierten #short("AAS")-Daten. Diese Applikation ist für die
fachliche Analyse der übermittelten Informationen zuständig, um aus den
Druckwerten wertvolle Erkenntnisse für die prädiktive Wartung zu
gewinnen und entsprechende Handlungsempfehlungen abzuleiten. Diese
architektonische Trennung gewährleistet auf konzeptioneller Ebene, dass
die Halbleiterfabrik die volle Souveränität über ihre Daten behält,
während der Equipmenthersteller auf standardisierte und autorisierte
Weise auf die für ihn relevanten Informationen zugreifen kann.

#include "../bilder/datenfluss.typ"

== Herleitung des Simulationsansatzes
<kap:herleitung-des-simulationsansatzes>
Die Implementierung einer prädiktiven Wartungsstrategie basiert
fundamental auf der Analyse von Daten, die den \"Gesundheitszustand\"
eines Systems widerspiegeln. Im betrachteten Anwendungsfall der
Halbleiter-Sub-Fab ist die Effizienz des Abgastransports von der
Prozesskammer zum Abatement-System von kritischer Bedeutung. Dieses
System (vgl. @fig:pumpenAbatementModell), bestehend
aus Pumpe, Rohrleitung und Abatement-System, bildet eine physikalisch
gekoppelte Einheit, deren Zustand maßgeblich durch die herrschenden
Druckverhältnisse bestimmt wird. Eine Abweichung der Druckdifferenz
zwischen dem Pumpenausgang und dem Abatement-Eingang von einem
definierten optimalen Betriebszustand ist ein starker Indikator für eine
beginnende Anomalie.


// #figure(image("../bilder/pumpe-abatement-schema.png", width: 80%), caption: [
//   Modellierung Pumpen-Abatement-Abgassystem
// ])

#include "../bilder/simulation.typ"

Da in der realen Produktionsumgebung keine Livedaten zur Verfügung
stehen und das gezielte Herbeiführen von Fehlfunktionen für Testzwecke
ausgeschlossen ist, ist die Simulation der physikalischen
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
Fehlerquellen, die in  @fig:pumpenAbatementModell skizziert sind, lassen sich verschiedene Wartungsszenarien ableiten, die
von der Simulation abgebildet werden müssen. Dazu gehören der optimale
Normalbetrieb, eine allmähliche Rohrverschmutzung, eine plötzliche
Verstopfung, diverse Formen des Pumpenverschleißes oder -defekts sowie
Leckagen im System. Die Korrelationen zwischen den Druckverhältnissen
und den daraus resultierenden Fehlerbildern lassen sich systematisch in
einer Matrix zusammenfassen, wie sie in @tab:druckverhaeltnisse dargestellt ist.



#let diag-header(row-label, col-label, width: 4cm, height: 1.5cm) = table.cell(
  inset: 0pt,
  box(width: width, height: height)[
    // Diagonale Linie von oben links nach unten rechts
    #place(line(start: (0%, 0%), end: (75%, 135%), stroke: 0.5pt))
    // Spalten-Label (oben rechts)
    #place(top + right, dx: -40pt, dy: 17pt)[#col-label]
    // Zeilen-Label (unten links)
    #place(bottom + left, dx: 20pt, dy: 0pt)[#row-label]
  ],
)

#figure(
  align(center)[#table(
    // columns: (4cm, 1fr, 1fr),
    columns: 5,
    align: left,
    table.header(
      diag-header([$p_"ist"^"P"$], [$p_"ist"^"A"$]),
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
@tab:use_cases_simulation aufgeführten Szenarien bilden
die Grundlage, um Algorithmen zu entwickeln, die eine Klassifizierung
dieser unterschiedlichen Fehlerbilder ermöglichen und somit eine
gezielte Wartungsempfehlung ableiten können.

#figure(
  placement: auto,
  align(center)[
    #set text(size: 0.9em)
    #set table(inset: (x: 5pt, y: 4.5pt))

    #table(
      columns: (1fr, auto, auto, auto, auto),
      align: left,
      table.header(
        [Use-Case], [Druck Pumpe \ \[mBar\]], [Druck Abatement \ \[mBar\]], [Pumpe \ Toleranz], [Abatement \ Toleranz]
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
    )
  ],
  caption: [Use-Cases für die Simulation],
  kind: table,
) <tab:use_cases_simulation>
#v(1.5em)

== Auswahl des Implementierungs-Frameworks: Eclipse BaSyx
<kap:auswahl-des-implementierungs-frameworks-eclipse-basyx>
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

Des Weiteren bietet BaSyx #shorts("SDK") für gängige Programmiersprachen wie Java,
C\# und Python, was eine hohe Flexibilität bei der Anwendungsentwicklung
gewährleistet. @EclipseBasyxGitHub

Eclipse BaSyx stellt eine modulare Middleware zur Verfügung, die alle
notwendigen Komponenten für den Aufbau einer #short("AAS")-basierten Infrastruktur
als einzelne, containerisierte Microservices bereitstellt. Diese Dienste
können kombiniert werden, um eine vollständige Laufzeitumgebung für
Digitale Zwillinge zu schaffen. @EclipseBasyxWiki

Der #strong[#short("AAS") Server];, oft auch als #strong[Repository] bezeichnet,
ist die Kernkomponente für das Hosting der eigentlichen #short("AAS")- und
Teilmodell-Instanzen. Er stellt eine standardisierte API (z.B.
HTTP/REST) bereit, über die auf die Inhalte des Digitalen Zwillings
zugegriffen, diese erstellt, gelesen, aktualisiert oder gelöscht werden
können.

Die #strong[#short("AAS") Registry] fungiert als zentrales Verzeichnis oder
\"Telefonbuch\" für die Verwaltungsschalen. Jede #short("AAS")-Instanz im System
wird hier mit ihrem eindeutigen Identifikator und dem Netzwerk-Endpunkt
ihres #short("AAS") Servers registriert. Anwendungen können die Registry abfragen,
um dynamisch herauszufinden, unter welcher Adresse eine bestimmte
Verwaltungsschale erreichbar ist.

Analog zur #short("AAS") Registry dient die #strong[Submodel Registry] der
Registrierung und dem Auffinden von einzelnen Teilmodellen. Dies
unterstützt eine dezentrale Architektur, in der Teilmodelle von
unterschiedlichen Servern bereitgestellt und dynamisch zu einer
Gesamt-#short("AAS") aggregiert werden können.

Aufbauend auf den Registries ermöglicht der #strong[Discovery];-Service
eine semantische Suche über den Bestand der Verwaltungsschalen. Anstatt
eine #short("AAS") über ihre eindeutige ID zu suchen, können Anwendungen hier
beispielsweise alle Assets abfragen, die über ein bestimmtes Teilmodell
(z.B. \"Technische Daten\") oder eine spezifische Eigenschaft verfügen.

Die #strong[#short("AAS") Environment];-Komponente fasst schließlich die
Gesamtheit aller #short("AAS")-bezogenen Elemente – also die AAS selbst, ihre
Teilmodelle und die zugehörigen semantischen Definitionen (Concept
Descriptions) – zusammen und stellt sie über eine einzige Schnittstelle
als kohärente Einheit bereit, was insbesondere den Austausch von
vollständigen Digitalen Zwillingen vereinfacht.

Obwohl alternative Open-Source-Implementierungen existieren, die sich
teils durch eine einfachere Inbetriebnahme auszeichnen, wurde Eclipse
BaSyx aufgrund seiner umfassenden Modularität und der vollständigen
Abdeckung des #short("AAS")-Standards als überlegen für die in dieser Arbeit
geforderte Realisierung bewertet. Die modulare Architektur von BaSyx
erlaubt es, die einzelnen Infrastrukturkomponenten gezielt aufzusetzen
und deren Zusammenspiel im Kontext des Eclipse Dataspace Connectors
detailliert zu untersuchen, was eine zentrale Anforderung dieser
wissenschaftlichen Arbeit ist.

== Entwurf des AAS-Modells
<kap:entwurf-des-aas-modells>
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
#short("AAS") fungiert als logische Klammer (Parent) für das gesamte zu
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

Die Struktur der Verwaltungsschale ist in @appendix:aasx-model beschrieben.

== Konzeption des souveränen Datenraums
<kap:konzeption-edc>
Um die informationstechnische Lücke zwischen dem Fabrikbetreiber (Datenanbieter) und dem Equipmenthersteller (Datennutzer) zu schließen, bedarf es einer Architektur, die den Austausch der generierten Equipmentdaten sicher und richtlinienbasiert ermöglicht. Der Kern dieses Konzepts ist die Etablierung eines dezentralen Datenraums unter Einsatz des #short("EDC").

Anders als bei herkömmlichen, tunnelbasierten Netzwerklösungen (wie etwa einem VPN), bei denen Systeme auf Netzwerkebene durchgereicht werden, fungiert der #short("EDC") als souveräner Daten-Proxy. Das bedeutet, dass die anbietende Domäne ihre Verwaltungsschalen nicht direkt exponiert. Stattdessen wird die Kommunikation in eine Kontrollebene und eine Datenebene aufgetrennt.

Konzeptionell sieht der lokale Aufbau zwei voneinander isolierte Konnektor-Instanzen vor: einen Provider-Konnektor auf Seiten der Halbleiterfabrik und einen Consumer-Konnektor auf Seiten des Equipmentherstellers. Der Datenaustauschprozess ist streng vertragsbasiert und durchläuft mehrere konzeptionelle Phasen:

*Katalogbereitstellung und -abfrage:* Der Provider-Konnektor aggregiert die verfügbaren Teilmodelle der #short("AAS") (spezifisch das `OperationalData`-Modell mit den Druckwerten) zu einem Datenkatalog. Jedes Datenangebot ist zwingend an eine maschinenlesbare Nutzungsrichtlinie geknüpft.

*Vertragsaushandlung:* Der Consumer-Konnektor fragt diesen Katalog ab und initiiert eine automatisierte Aushandlung. Stimmen die Anforderungen des Nutzers mit den Richtlinien des Anbieters überein, wird ein bindendes Abkommen generiert.

*Autorisierter Transfer:* Erst nach erfolgreichem Vertragsabschluss tauschen die Kontrollebenen kryptografische Token aus. Die Datenebene des Datennutzers erhält daraufhin eine gesicherte Endpunkt-Referenz, über die der tatsächliche #short("HTTP")-Datenstrom der #short("AAS")-Druckwerte abgerufen werden kann.

Durch dieses Proxy-Pattern wird sichergestellt, dass die Datenhoheit jederzeit beim Fabrikbetreiber verbleibt, während der Equipmenthersteller einen genormten, sicheren Zugriffspunkt für seine Analysedienste erhält.


== Konzeption der Client-Anwendung und Visualisierung
<kap:konzeption-client-visualisierung>
Die konzeptionelle Kette des souveränen Datenaustauschs endet in der Domäne des Datennutzers. Um die bereitgestellten Informationen der Verwaltungsschale domänenspezifisch verwerten zu können, wird eine dedizierte Client-Anwendung als informationstechnischer Endpunkt entworfen. Der Architekturansatz dieses Clients ist modular und evolutionär aufgebaut: Zur initialen Validierung der reinen Kommunikations- und Ausleselogik ist das System so konzipiert, dass es zunächst direkt mit der #short("AAS")-Laufzeitumgebung interagieren kann. In der finalen Ausbaustufe der Architektur wird diese direkte Verbindung durch den #short("EDC") als obligatorischen Proxy substituiert, um den souveränen Datenaustausch zu erzwingen.

Der konzeptionelle Workflow des Clients im vollständig integrierten Datenraum gliedert sich in vier logische Phasen: Vertragsaushandlung, Datenabruf, Auswertung und Persistierung.

Zunächst interagiert der Client als aktiver Konsument mit dem #short("EDC"). Er fragt den bereitgestellten Angebotskatalog des Datenanbieters ab und initiiert die Aushandlung der Nutzungsbedingungen. Nach der erfolgreichen Akzeptanz des digitalen Vertrages erhält der Client einen temporären Zugangsschlüssel, der ihn für den nachfolgenden Datentransfer autorisiert.

Mit diesem Schlüssel erfolgt der eigentliche Datenabruf. Die konzeptionelle Herausforderung dieses Schrittes liegt in der korrekten informationstechnischen Adressierung: Um die dynamischen Druckwerte punktgenau abzufragen, muss der Client die exakten, eindeutigen Identifikatoren (Submodel-IDs) der Ziel-Assets – der Vakuumpumpe und des Abatement-Systems – kennen. Nur mit diesen Referenzen kann die Anfragelogik die relevanten Parameter aus der Hierarchie der Verwaltungsschale zielgerichtet extrahieren.

Nach dem erfolgreichen Abruf der Livedaten findet die analytische Auswertung direkt im Client statt. Anstelle eines ressourcenintensiven Modells des maschinellen Lernens sieht das Konzept eine deterministische, schwellwertbasierte Analysekomponente vor. Basierend auf der zuvor definierten Simulationsmatrix (vgl. @tab:druckverhaeltnisse) vergleicht die Logik die abgerufenen Druckdifferenzen kontinuierlich mit definierten Toleranzbändern. Überschreitet beispielsweise der Druck an der Pumpe einen Schwellwert bei gleichzeitigem Druckabfall am Abatement, klassifiziert das System dieses Ereignis automatisch als Anomalie, etwa als Rohrverstopfung.

Um diese abgeleiteten Zustandsbewertungen sowie die rohen Druckverläufe für das Wartungspersonal nutzbar zu machen, schließt das Konzept mit der methodischen Trennung von Datenverarbeitung und Präsentation ab. Der Client persistiert die abgerufenen und ausgewerteten Datenpunkte fortlaufend in einem strukturierten, generischen Speicherformat. Ein eigenständiges Visualisierungs-Frontend greift anschließend rein lesend auf diesen Speicher zu und transformiert die abstrakten Zeitreihen in anschauliche Graphen. Diese strikte Entkopplung gewährleistet ein performantes Condition Monitoring: Das Frontend fungiert lediglich als visuelles Dashboard, während die gesamte komplexe Geschäftslogik, die Vertragsaushandlung und die Auswertung sicher im Client gekapselt bleiben.

Darüber hinaus ist die Architektur des Clients gezielt darauf ausgelegt, eine nahtlose Integration in die bestehende Unternehmens-IT des Equipmentherstellers, insbesondere in übergeordnete  #short("ERP")-System, zu ermöglichen. Der konzeptionelle Mehrwert dieses Ansatzes liegt in der Überwindung proprietärer Insellösungen: Anstatt für jeden Fabrikbetreiber individuelle und wartungsintensive Schnittstellen pflegen zu müssen, fungiert der Client als standardisierter Adapter. Er übersetzt die normierten #short("AAS")-Daten aus dem souveränen Datenraum in das interne Datenformat des Herstellers.

// Sobald die im Client gekapselte, deterministische Analyse eine kritische Anomalie detektiert, kann dieser Zustand als strukturierter Trigger direkt an das #short("ERP")-System übermittelt werden. Dies ermöglicht die vollständige Automatisierung nachgelagerter Geschäftsprozesse: Von der automatischen Generierung von Service-Tickets über die Disposition notwendiger Ersatzteile bis hin zur proaktiven Einsatzplanung von Wartungstechnikern. Die strikte architektonische Trennung von souveränem Datenabruf und interner Datenverwertung stellt somit sicher, dass der Equipmenthersteller die Maschinendaten hochskalierbar und sicher in seine etablierten Wertschöpfungsprozesse einbetten kann, ohne direkte Eingriffe in die kritische Infrastruktur der Halbleiterfabrik vornehmen zu müssen.



== Architektonische Erweiterbarkeit für KI-gestützte Analyseverfahren
<kap:konzeption-ki-erweiterbarkeit>
Diese umfassen insbesondere die Anbindung externer Machine-Learning-Dienste an den etablierten Datenraum, um die avisierte KI-gestützte Analyse auf Basis der geschaffenen Infrastruktur vollständig zu realisieren.
Ein zentrales Motiv bei der Konzeption dieser Datenpipeline ist die Schaffung einer zukunftssicheren und skalierbaren Infrastruktur, die perspektivisch auch hochkomplexe Auswertungsmethoden unterstützt. Die in der ursprünglichen Zielsetzung avisierte KI zur Mustererkennung von Fehlerfällen wird in diesem Architekturkonzept bewusst als entkoppelte, nachgelagerte Instanz betrachtet. Der Fokus liegt auf der Etablierung einer robusten, standardisierten Datenbasis, die als technologischer Wegbereiter  für derartige fortgeschrittene Analyseverfahren fungiert.

Durch die konsequente Nutzung der #short("AAS") als normiertes semantisches Informationsmodell und des #short("EDC") als souveränen Transportweg entsteht eine hochgradig generische Schnittstellenarchitektur. Diese strikte Standardisierung bedingt, dass eine zukünftige KI-Anwendung nicht als proprietäres, monolithisches Modul tief in den lokalen Client integriert werden muss. Vielmehr kann ein solches System – sei es ein lokaler Machine-Learning-Dienst oder eine cloudbasierte Analyseplattform – als eigenständiger, weiterer Konsument innerhalb des Datenraums agieren. Eine solche Anwendung ist in der Lage, die historischen und echtzeitnahen Druckwerte über etablierte Web-Standards (wie etwa #short("REST")-Schnittstellen) verlustfrei und vertraglich abgesichert abzurufen.

Für den informationstechnischen Nachweis der Pipeline im Rahmen dieser Ausarbeitung ist die im Client implementierte deterministische Schwellwertanalyse vollkommen ausreichend, um die grundsätzliche informationstechnische Machbarkeit der prädiktiven Wartung zu belegen. Externe KI-Dienste können durch die generische Natur des #short("EDC") jederzeit nahtlos an den souveränen Datenraum angebunden werden, ohne dass tiefgreifende strukturelle Anpassungen an der bestehenden Infrastruktur der Halbleiterfabrik oder des primären Clients vorgenommen werden müssen.
