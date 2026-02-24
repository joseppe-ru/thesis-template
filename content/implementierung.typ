#import "../utils.typ": *
= Implementierung
<implementierung>
// == Evaluation der Datenraum Konnektivität
// <evaluation-der-datenraum-konnektivität>
// Vor der Implementierung der vollständigen Datenpipeline war eine
// grundlegende Evaluation der Datenraum-Technologie erforderlich. Zu
// diesem Zweck wurden exemplarische Anwendungsfälle des Eclipse Dataspace
// Connectors (EDC) anhand der bereitgestellten Tutorials nachvollzogen und
// analysiert. Der Fokus dieser explorativen Phase lag darauf, die
// fundamentalen Mechanismen für einen souveränen Datenaustausch zu
// verstehen. Wesentliche Erkenntnisse konnten hinsichtlich des Aushandelns
// von Datennutzungsverträgen (Contract Negotiation) und des
// anschließenden, gesicherten Datentransfers gewonnen werden. Insbesondere
// wurde die Übertragung von generischen Payloads über die
// HTTP-Schnittstelle des EDC erprobt, um das grundlegende Verfahren zu
// validieren, mit dem später die Verwaltungsschalen als schützenswerte
// Datenassets zwischen den Teilnehmern des Datenraums ausgetauscht werden
// sollen.

== Aufbau der AAS-Laufzeitumgebung
<aufbau-der-aas-laufzeitumgebung>
Die serverseitige Grundlage für die Bereitstellung der Digitalen
Zwillinge wurde unter Verwendung der offiziellen
#strong[“Off-the-Shelf“-Komponenten] von Eclipse BaSyx realisiert.
@EclipseBasyxWiki Dieser Ansatz nutzt von den Entwicklern
bereitgestellte, vorgefertigte Docker-Images, was den Aufbau einer
standardkonformen und reproduzierbaren Systemumgebung erheblich
vereinfacht. Für die in dieser Arbeit benötigte Kernfunktionalität
wurden dabei insbesondere die Images für den #short("AAS")-Server
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
“docker-compose“-Konfiguration ist im @appendix:docker-compose-basyx detailliert dokumentiert.


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
Auf Basis der in @entwurf-des-aas-modells konzipierten hierarchischen
Struktur (vgl. #strong[Anhang @appendix:aasx-model];) wurden die
konkreten Verwaltungsschalen für das Abgassystem erstellt. Ein zentrales
Kriterium bei der Modellierung war die maximale Wiederverwendung von
standardisierten Bausteinen, um die Interoperabilität zu gewährleisten.
Daher wurden für Aspekte, die einer branchenweiten Standardisierung
unterliegen, offizielle Teilmodell-Templates aus dem öffentlichen
Git-Repository der #short("IDTA") verwendet
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
späteren Transfer durch den Datenraum. (vgl. @fig:packageexplorer)

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
@tab:druckverhaeltnisse) wählen oder manuell
spezifische Drucksollwerte eingeben, um individuelle Tests
durchzuführen. So können gezielt Daten für alle relevanten Zustände –
vom Optimalbetrieb bis zum vollständigen Systemausfall – erzeugt werden.

Die Anbindung des Simulators an die in @aufbau-der-aas-laufzeitumgebung aufgebaute
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

Die @fig:drucksimulator zeigt die GUI des
Python-Drucksimulators. Über Knopfdruck lassen sich die verschiedenen
Use-Cases wie in @tab:use_cases_simulation beschrieben
bedienen.

#figure(image("../bilder/drucksimulator.png", width: 80%), caption: [
  Python Drucksimulator GUI
])
<fig:drucksimulator>



== Bereitstellung der lokalen EDC-Infrastruktur
<impl-edc-infrastruktur>
Die praktische Realisierung des souveränen Datenraums erfolgte durch die lokale Instanziierung des #short("EDC"). Um eine realitätsnahe Trennung der Domänen abzubilden, wurden zwei separate Konnektor-Instanzen – ein Provider-Konnektor und ein Consumer-Konnektor – auf Basis der offiziellen #short("EDC")-Samples kompiliert und bereitgestellt. @EDCSamples Die spezifische Konfiguration der jeweiligen Laufzeitumgebungen, wie etwa die Definition der Netzwerk-Ports und der anzubindenden Backend-Dienste, wurde über dedizierte Konfigurationsdateien (`provider-config.properties` und `consumer-config.properties`) realisiert. Zur Gewährleistung einer reproduzierbaren und plattformunabhängigen Ausführung wurde die gesamte Infrastruktur mittels Docker-Compose orchestriert.

Die Validierung der Kontrollebene (Control Plane) und der fehlerfreien Konnektivität zwischen den beiden Domänen wurde iterativ mittels der #short("API")-Entwicklungsplattform Postman durchgeführt. Durch eine eigens erstellte Postman-Collection konnten die essenziellen #short("HTTP")-Aufrufe zur Erstellung von Datenangeboten auf Provider-Seite sowie die Abfrage des Katalogs auf Consumer-Seite manuell ausgelöst und verifiziert werden. Dieser semi-automatisierte Testansatz stellte sicher, dass die kryptografische und logische Infrastruktur des Datenraums funktionsfähig ist, bevor die Client-Applikation angebunden wurde.


Die Postman-Collection und die EDC-configurations Dateieen sowie das Docker-Compose script sind auf dem Gitlab der HTW-Dresden zu finden unter `Wintersemester_2026`. @iversion

== Die Client-Applikation
<impl-client-applikation>
Den informationstechnischen Abschluss der Datenpipeline bildet eine objektorientierte Konsolenanwendung. Diese wurde in Java (Version 17) unter Verwendung des Build-Management-Tools Maven (`de.htw_dresden.jrudolph:aas_consumer_client`) realisiert. Die interne Softwarearchitektur ist in die logischen Pakete `configuration`, `processing` und `util` gegliedert und folgt strikt etablierten Entwurfsmustern, um eine hohe Wartbarkeit und Skalierbarkeit zu gewährleisten.

Die zentrale Steuerung und Konfiguration der Anwendung erfolgt dynamisch über Umgebungsvariablen. Diese Parameter – wie beispielsweise Verbindungs-URLs, das gewählte Abrufverfahren und Authentifizierungsschlüssel – werden zur Laufzeit in einem unveränderlichen Datenobjekt, dem `EndpointRecord`, gekapselt. Der Einsatz von Java Records garantiert hierbei eine threadsichere und speichereffiziente Haltung der Konfigurationsdaten.

Abhängig von der übergebenen Umgebungsvariable instanziiert das System über das Factory/Builder-Pattern unterschiedliche Strategien zur Datenbeschaffung. Für Entwicklungs- und Validierungszwecke kann die Applikation eine direkte Anbindung an die BaSyx-Laufzeitumgebung (`BaSyxPressureProvider`) nutzen. Im produktiven Zielszenario wird jedoch dynamisch auf den `EDCPressureProvider` umgeschaltet, welcher native #short("HTTP")-Requests an den souveränen Datenraum richtet und den vertraglich ausgehandelten Autorisierungsschlüssel für den Datenabruf injizieren kann.

Der kontinuierliche Abruf der Sensordaten wird im Hintergrund durch die Klasse `PressureWatcher` orchestriert, welche als eigenständiger Thread ausgeführt wird. Um die Datenbeschaffung von der anschließenden Verwertung informationstechnisch zu entkoppeln, wurde ein ereignisgesteuerter Ansatz gewählt. Sobald der `PressureWatcher` einen neuen validen Datensatz (`PressureRecord`) empfängt, benachrichtigt er alle registrierten Abonnenten, die das `PressureListener`-Interface implementieren.

In dieser konkreten Implementierung sind zwei primäre Listener registriert:

*Der `PressureAnalyser`:* Diese Komponente fungiert als Aufpasser und logische Schnittstelle für die Auswertung der Druckdifferenzen. Durch die generische Architektur dient diese Klasse als exakter informationstechnischer Ankerpunkt, an dem in zukünftigen Ausbaustufen komplexe Modelle zur Mustererkennung oder Algorithmen der künstlichen Intelligenz nahtlos und ohne tiefgreifende Refactorings des Clients integriert werden können.

*Der `CsvWriter`:* Diese Komponente übernimmt die Persistierung der extrahierten Daten. Bei jedem Eintreffen neuer Werte schreibt der Writer die Druckdaten der Pumpe und des Abatement-Systems, angereichert mit einem exakten Zeitstempel, in den lokalen Speicher. Die Entscheidung für das #short("CSV")-Format fiel hierbei bewusst: Es bietet eine hohe maschinelle Kompatibilität für nachgelagerte Dashboards, ist ressourcenschonend und bleibt gleichzeitig direkt durch den Menschen (bspw. das Wartungspersonal) lesbar und interpretierbar.

Der Einstiegspunkt der Applikation (`Application.java`) demonstriert diese saubere Trennung der Zuständigkeiten, indem er die Komponenten über ihre jeweiligen Builder instanziiert, die Listener registriert und den asynchronen Überwachungsprozess startet.

Der Quellcode ist wiederzufinden im GitLab der HTW Dresden unter "WinterSemester_25-26/aas_client/aas_consumer_client". @iversion


#include "../bilder/app.typ"



=== Autorisierung und Vertragsaushandlung
<impl-client-auth>
Um als legitimer Datennutzer im souveränen Datenraum agieren zu können, muss der Client den vertraglich gesicherten Abrufmechanismus implementieren. Anstatt das proprietäre BaSyx-#short("SDK") für direkte Anfragen zu nutzen, generiert der Client native #short("HTTP")-Requests. Der Prozess erfolgt zweistufig: Zunächst ruft die Applikation über den lokalen Consumer-Konnektor die  #short("EDR")) ab. Die #short("JSON")-Antwort dieses Aufrufs enthält einen temporären Autorisierungsschlüssel (`authorization`).

Dieser Schlüssel wird vom Client extrahiert, im Speicher vorgehalten und für alle nachfolgenden Abfragen in den #short("HTTP")-Header der GET-Requests injiziert. Mit dieser Autorisierung fragt der Client periodisch die spezifischen #short("AAS")-Endpunkte für die Druckwerte der Vakuumpumpe und des Abatement-Systems ab. Die aus dem #short("JSON")-Payload der Verwaltungsschale extrahierten Werte werden unmittelbar in strukturierte Laufzeitobjekte (`PressureRecord`) überführt. Innerhalb der Applikation greift anschließend der `PressureAnalyser`, welcher die abgerufenen Druckdifferenzen anhand deterministischer Schwellwerte evaluiert, um Anomalien wie Rohrverstopfungen algorithmisch zu detektieren.

=== Datenpersistierung
<impl-client-persistierung>
Für die nachgelagerte historische Analyse und die visuelle Aufbereitung müssen die flüchtigen `PressureRecord`-Objekte persistent gespeichert werden. Dies übernimmt die Komponente `CsvWriter`, welche ebenfalls als Observer in den Datenfluss eingehängt ist. Bei jedem Eintreffen neuer Sensordaten transformiert diese Klasse die Druckwerte von Pumpe und Abatement sowie das Ergebnis der Schwellwertanalyse in einen kommagetrennten Datensatz. Um die zeitliche Chronologie zu wahren, wird jedem Eintrag ein präziser System-Zeitstempel (Timestamp) hinzugefügt. Die resultierende #short("CSV")-Datei wird fortlaufend in einem dedizierten lokalen Verzeichnis aggregiert.

=== Visualisierung
<impl-client-visualisierung>
Die Präsentationsschicht des Systems wurde konzeptionell strikt von der Datenbeschaffung getrennt. Als Visualisierungs-Frontend kommt die Open-Source-Plattform Grafana zum Einsatz, welche als eigenständiger Docker-Container parallel zum Client betrieben wird. Die informationstechnische Kopplung zwischen dem Java-Client und Grafana erfolgt über ein Shared Volume auf Basis des Host-Dateisystems.

Grafana greift über ein spezialisiertes #short("CSV")-Plugin lesend auf die vom Client generierte Datei zu. In der Weboberfläche von Grafana wurden spezifische Dashboards konfiguriert, welche die tabellarischen Zeitreihendaten in dynamische, leicht interpretierbare Liniendiagramme übersetzen. Diese Architektur ermöglicht ein echtzeitnahes Condition Monitoring der simulierten Assets und schließt die Wirkkette vom Datengenerator über den souveränen Datenraum bis hin zum visuellen Endpunkt erfolgreich ab.

