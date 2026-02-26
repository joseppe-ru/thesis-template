#import "../utils.typ": *
= Tests und Ergebnisse
<kap:tests-und-ergebnisse>



== Automatisierte Bereitstellung des Demonstrators
<kap:eval-orchestrierung>
Die Zusammenführung der einzelnen Domänen zu einer funktionsfähigen Gesamtarchitektur erfordert eine präzise Orchestrierung der verteilten Systemkomponenten. Um eine deterministische und plattformunabhängige Reproduzierbarkeit (evaluiert unter einer Linux-Umgebung) zu gewährleisten, wurde die gesamte Startroutine in einem zentralen Shell-Skript (`run_full_setup.sh`) automatisiert (vgl. @appendix:runsetup). Der zugehörige Quellcode sowie die Konfigurationsdateien werden im GitLab der HTW Dresden (Zweig "Wintersemester2025_26", @iversion) vorgehalten.

Dieses Skript fungiert als übergeordneter Orchestrator und startet die Microservices in einer sequenziellen Reihenfolge:

+ *Datenanbieter:* Initialisierung der #short("AAS")-Laufzeitumgebung via Docker Compose.

+ *Datengenerierung:* Start des Python-Drucksimulators in einer isolierten virtuellen Umgebung (`venv`). Das Skript implementiert hierbei eine automatische Vorabprüfung der benötigten Systemabhängigkeiten (wie `simpy` und `requests`), um Laufzeitfehler frühzeitig abzufangen.

+ *Datenraum:* Bereitstellung des Provider- und Consumer-Konnektors.

+ *Datennutzer:* Automatisierter Build-Prozess und Start des Java-basierten #short("AAS")-Clients sowie des Grafana-Dashboards.

== Evaluation der souveränen Datenpipeline
<kap:eval-workflow>
Nach der erfolgreichen, fehlerfreien Ausführung des Orchestrierungs-Skripts wurde der Gesamtsystem-Workflow – vom Asset bis zum Dashboard – in einem integralen Systemtest evaluiert. Dieser Test durchläuft alle informationstechnischen Stationen und verifiziert das Zusammenspiel der im Wintersemester entwickelten Komponenten.

=== Datengenerierung und -bereitstellung
Der Testlauf beginnt in der grafischen Oberfläche des Python-Simulators. Durch die manuelle Triggerung eines spezifischen Wartungsszenarios (beispielsweise "Rohrverstopfung") wird die Generierung veränderter Druckwerte initiiert. Wie in @fig:pythonsimulatorui auf der linken Seite dargestellt lässt die Benutzeroberfläche sowohl die Auswahl vorgefertigter Wartungsszenarien zu als auch manuelle Eingabe von Werten.

#figure(image("../bilder/sim_ui.png"), caption: [
  Benutzeroberfläche des Simulators
])
<fig:pythonsimulatorui>

Die erfolgreiche Übermittlung via HTTP-PATCH an den lokalen BaSyx-Server lässt sich in der #short("AAS")-Web-UI (`localhost:3000`) verifizieren. Die Verwaltungsschale spiegelt die simulierten Druckdifferenzen in Echtzeit wider. Wie in @fig:aaswebui dargestellt, werden die Druckwerte direkt für die richtigen Submodeltemplates eingetragen. Ebenso wird die Struktur der Verwaltungsschale über die grafische Ansicht der Weboberfläche deutlich.

#figure(image("../bilder/basyx_wu_ui.png"), caption: [
  Webansicht der Verwaltungsschale
])
<fig:aaswebui>

=== Vertragsaushandlung und Datentransfer
Der kritische Pfad dieses Systemtests ist die Überwindung der Domänengrenze. Der Java-Client initiiert vollautomatisiert die Vertragsaushandlung über den lokalen #short("EDC")-Consumer-Konnektor. Die Analyse der Docker-Logs des Konnektors bestätigt den erfolgreichen Austausch der kryptografischen Token. Der Client nutzt den erhaltenen Zugangsschlüssel, um die Live-Daten der #short("AAS") über den #short("EDC")-Proxy abzufragen. Der souveräne Datenraum blockiert in diesem Testaufbau gezielt alle unautorisierten Direktanfragen und lässt ausschließlich Zugriffe mit gültigem Token passieren, was die Einhaltung der Datensouveränität informationstechnisch belegt.

In @appendix:aasclilog ist ein Auszug aus dem log der Client-Anwendung zu finden, welche mit dem Befhel `docker logs aas_consumer_client -f` ausgegeben werden können.

=== Auswertung, Persistierung und Visualisierung:
In der Endpunkt-Domäne validiert der Test die korrekte Verarbeitung der JSON-Antworten. Der im Java-Client integrierte `CsvWriter` extrahiert die ankommenden Druckwerte und schreibt diese iterativ, versehen mit einem korrekten Zeitstempel, in die lokale `pressure_data.csv`. Den finalen visuellen Nachweis des Workflows liefert das Grafana-Dashboard (`localhost:3001`). Die Web-Oberfläche liest die #short("CSV")-Datei erfolgreich über das angebundene Volume ein und transformiert die Datenpunkte in dynamische Liniendiagramme. In @fig:grafana zu sehen ist auf der linken Seite der historische Plot und auf der rechten Seite eine tabellarische Ansicht der Druckwerte.

#figure(image("../bilder/grafana.png"), caption: [
  Grafana - Visualisierung der Druckwerte
])
<fig:grafana>
