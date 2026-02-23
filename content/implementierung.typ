= Implementierung
<implementierung>
== Evaluation der Datenraum Konnektivität
<evaluation-der-datenraum-konnektivität>
Vor der Implementierung der vollständigen Datenpipeline war eine
grundlegende Evaluation der Datenraum-Technologie erforderlich. Zu
diesem Zweck wurden exemplarische Anwendungsfälle des Eclipse Dataspace
Connectors (EDC) anhand der bereitgestellten Tutorials nachvollzogen und
analysiert. Der Fokus dieser explorativen Phase lag darauf, die
fundamentalen Mechanismen für einen souveränen Datenaustausch zu
verstehen. Wesentliche Erkenntnisse konnten hinsichtlich des Aushandelns
von Datennutzungsverträgen (Contract Negotiation) und des
anschließenden, gesicherten Datentransfers gewonnen werden. Insbesondere
wurde die Übertragung von generischen Payloads über die
HTTP-Schnittstelle des EDC erprobt, um das grundlegende Verfahren zu
validieren, mit dem später die Verwaltungsschalen als schützenswerte
Datenassets zwischen den Teilnehmern des Datenraums ausgetauscht werden
sollen.

== Aufbau der AAS-Laufzeitumgebung
<aufbau-der-aas-laufzeitumgebung>
Die serverseitige Grundlage für die Bereitstellung der Digitalen
Zwillinge wurde unter Verwendung der offiziellen
#strong[“Off-the-Shelf“-Komponenten] von Eclipse BaSyx realisiert.
@EclipseBasyxWiki Dieser Ansatz nutzt von den Entwicklern
bereitgestellte, vorgefertigte Docker-Images, was den Aufbau einer
standardkonformen und reproduzierbaren Systemumgebung erheblich
vereinfacht. Für die in dieser Arbeit benötigte Kernfunktionalität
wurden dabei insbesondere die Images für den #strong[AAS Server]
(Repository), die #strong[AAS Registry] sowie den übergeordneten
#strong[AAS Environment];-Service verwendet.

Die Orchestrierung und Konfiguration dieser containerisierten Dienste
erfolgte mittels einer “docker-compose“-Datei. Als Ausgangspunkt dienten
hierfür die von der BaSyx-Community bereitgestellten
Beispielkonfigurationen @EclipseBasyxJavaServerSDK, welche für die
spezifischen Anforderungen dieses Projekts adaptiert wurden. Diese
Anpassungen umfassten unter anderem die Netzwerkkonfiguration, um eine
reibungslose Kommunikation zwischen den einzelnen Diensten
sicherzustellen. Die resultierende, für diese Arbeit verwendete
“docker-compose“-Konfiguration ist im #strong[Anhang
  @appendix:docker-compose-basyx] detailliert dokumentiert.

Nach dem erfolgreichen Start der Laufzeitumgebung erfolgt die gesamte
Interaktion mit den Verwaltungsschalen über eine standardisierte
HTTP/REST-Schnittstelle, die von den BaSyx-Diensten bereitgestellt wird.
Die explorative Analyse der API ergab, dass mittels GET-Anfragen sowohl
das Auffinden von Verwaltungsschalen über die Registry als auch das
gezielte Auslesen von AAS, Teilmodellen und einzelnen Eigenschaften
möglich ist. Für die dynamische Aktualisierung der Digitalen Zwillinge,
wie sie später durch den Simulator erfolgt, kommen “PUT“-Anfragen zum
Einsatz, mit denen die Werte einzelner Eigenschaften (Properties)
überschrieben werden können. Eine wesentliche technische Erkenntnis bei
der Arbeit mit der API war, dass Identifikatoren für den Transfer
Base64-kodiert sein müssen, um eine URI-konforme Übertragung zu
gewährleisten. Besonders entwicklerfreundlich ist, dass der
Environment-Service eine interaktive Weboberfläche bereitstellt, auf der
die gesamte API-Definition live abgefragt und getestet werden kann.

== Modellierung und Erstellung der Verwaltungsschalen
<modellierung-und-erstellung-der-verwaltungsschalen>
Auf Basis der in #strong[Kapitel 3.4] konzipierten hierarchischen
Struktur (vgl. #strong[Anhang @appendix:aasx-model];) wurden die
konkreten Verwaltungsschalen für das Abgassystem erstellt. Ein zentrales
Kriterium bei der Modellierung war die maximale Wiederverwendung von
standardisierten Bausteinen, um die Interoperabilität zu gewährleisten.
Daher wurden für Aspekte, die einer branchenweiten Standardisierung
unterliegen, offizielle Teilmodell-Templates aus dem öffentlichen
Git-Repository der Industrial Digital Twin Association (IDTA) verwendet
@AdminShellIOSubmodelTemplates.

Für die grundlegende Identifikation aller Assets kam das Template
#strong[“Digital Nameplate“] zum Einsatz. Dieses weit verbreitete
Teilmodell dient der Bereitstellung von Kerninformationen, die
typischerweise auf einem physischen Typenschild zu finden sind, wie
beispielsweise Herstellername (`ManufacturerName`), Produktbezeichnung
(`ManufacturerProductDesignation`) und Seriennummer (`SerialNumber`).
Durch die Nutzung dieses standardisierten Templates wird sichergestellt,
dass jede Komponente im System ihre Stammdaten in einer einheitlichen,
maschinenlesbaren Form präsentiert.

Da für die Erfassung der dynamischen Betriebsdaten kein universelles
Standard-Template existiert, das die spezifischen Anforderungen dieses
Anwendungsfalls abdeckt, wurde das anwendungsspezifische Teilmodell
#strong[“OperationalData“] eigens für diese Arbeit konzipiert und
erstellt. Dieses Teilmodell ist der zentrale Baustein für die spätere
Analyse und enthält die für die prädiktive Wartung entscheidenden
Eigenschaften (Properties). In der Verwaltungsschale der Pumpe
(`IndustrialExhaustPump`) und des Abatement-Systems (`AbatementSystem`)
wurde jeweils eine Eigenschaft namens #strong[“Actual Pressure“]
implementiert. Diese repräsentiert den momentanen Ist-Druck am
jeweiligen Messpunkt und dient als direkter Eingang für die
Simulationsdaten, ohne dabei einen historischen Verlauf zu speichern.

Die Erstellung der finalen `.aasx`-Paketdateien, welche die
konfigurierten Verwaltungsschalen mit ihren standardisierten und
anwendungsspezifischen Teilmodellen enthalten, erfolgte mit dem
#strong[AASX Package Explorer] @EclipseAASPEPackageExplorer. Dieses
Werkzeug ermöglicht die grafische Komposition der verschiedenen
Teilmodelle, die Konfiguration der spezifischen Eigenschaftswerte (z.B.
das Eintragen der Seriennummern) und die Bündelung aller zugehörigen
Informationen in einer einzigen, austauschbaren Datei. Ein solches
AASX-Paket repräsentiert den vollständigen, in sich geschlossenen
Digitalen Zwilling eines Assets und bildet die Datengrundlage für den
späteren Transfer durch den Datenraum. (vgl. #strong[Abbildung
  @fig:packageexplorer];)

#figure(image("../bilder/packageexplorer.png", width: 80%), caption: [
  Bearbeiten der Verwaltungsschale mit dem AASX-Packageexplorer
])
<fig:packageexplorer>

== Realisierung und Anbindung des Drucksimulators
<realisierung-und-anbindung-des-drucksimulators>
Die Generierung der für die Analyse notwendigen Livedaten erfolgt durch
einen eigens für diese Arbeit entwickelten, prozessbasierten Simulator.
Als technologische Basis wurde die Programmiersprache #strong[Python] in
Kombination mit der Bibliothek #strong[SimPy] gewählt. Python bietet
durch sein reichhaltiges Ökosystem an Bibliotheken eine hervorragende
Grundlage für wissenschaftliche und datenintensive Anwendungen, während
SimPy als prozessbasiertes Framework für diskrete Ereignissimulationen
besonders geeignet ist, um das zeitliche Verhalten von Systemen, wie den
schleichenden Anstieg einer Rohrverschmutzung oder plötzliche Defekte,
realitätsnah abzubilden. Der Simulator ist architektonisch in zwei
parallel laufende Prozesse aufgeteilt, die mittels Multithreading
realisiert wurden: ein Prozess ist für die GUI und die Nutzerinteraktion
zuständig, der andere für die kontinuierliche Generierung der Druckwerte
und die Kommunikation mit der AAS-Infrastruktur.

Die Kernfunktionalität des Simulators ist die Erzeugung der Druckwerte
für die Pumpe und das Abatement-System. Um abrupte Sprünge zu vermeiden
und ein realistisches, träges Systemverhalten nachzubilden, werden die
Ist-Druckwerte iterativ an die Soll-Werte angenähert. Dies simuliert den
langsamen Druckauf- oder -abbau in einem physischen System. Über die
grafische Benutzeroberfläche kann der Anwender gezielt zwischen den
zuvor in der Szenarien-Matrix definierten Wartungsfällen (vlg.
#strong[Tabelle @tab:druckverhaeltnisse];) wählen oder manuell
spezifische Drucksollwerte eingeben, um individuelle Tests
durchzuführen. So können gezielt Daten für alle relevanten Zustände –
vom Optimalbetrieb bis zum vollständigen Systemausfall – erzeugt werden.

Die Anbindung des Simulators an die in #strong[Kapitel 4.2] aufgebaute
AAS-Laufzeitumgebung erfolgt über deren REST-API. In einem
kontinuierlichen Prozess übermittelt der Simulator die aktuell
generierten Ist-Druckwerte mittels einer HTTP-‘PATCH‘-Anfrage (eine
spezifischere Form der ‘POST‘-Anfrage zur Aktualisierung eines Teils
einer Ressource) an das entsprechende ‘Property‘-Element im
‘OperationalData‘-Teilmodell der jeweiligen Verwaltungsschale. Dieser
Ansatz wurde bewusst gewählt, da er das typische Verhalten von
IoT-fähigen Sensoren oder Mikrocontrollern nachbildet, die ihre
Messwerte ebenfalls über etablierte Netzwerkprotokolle an übergeordnete
Systeme senden. Der Simulator agiert somit als valider und
realitätsnaher Stellvertreter für die physischen Assets in der
Zielarchitektur.

Die #strong[Abbildung @fig:drucksimulator] zeigt die GUI des
Python-Drucksimulators. Über Knopfdruck lassen sich die verschiedenen
Use-Cases wie in #strong[Tabelle @tab:use_cases_simulation] beschrieben
bedienen.

#figure(image("../bilder/drucksimulator.png", width: 80%), caption: [
  Python Drucksimulator GUI
])
<fig:drucksimulator>
