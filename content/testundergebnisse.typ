= Tests und Ergebnisse
<tests-und-ergebnisse> == Funktionalitätstest der AAS-Laufzeitumgebung <funktionalitätstest-der-aas-laufzeitumgebung> Nach dem Aufbau der Systemumgebung gemäß Kapitel 4.2 wurde die korrekte Funktion der AAS-Laufzeitumgebung verifiziert. Die Inbetriebnahme erfolgte durch die Ausführung des Befehls `docker compose up -d`, welcher alle in der Konfigurationsdatei definierten BaSyx-Dienste als dezentralisierte Container im Hintergrund startet. Die erfolgreiche Initialisierung wurde unmittelbar durch die Überprüfung der Erreichbarkeit der zentralen Service-Endpunkte auf dem lokalen Host bestätigt. Dazu zählten das #strong[AAS Repository]
(“http:\/\/localhost:8081/shells“), die #strong[AAS Registry]
(“http:\/\/localhost:8082/shell-descriptors“), die #strong[Submodel
  Registry] (“http:\/\/ localhost:8083/submodel-descriptors“), der
#strong[Discovery-Service] (“http:\/\/localhost:8084/lookup/shells“)
sowie die grafische #strong[AAS Web UI] (“http:\/\/localhost:3000“)
(vgl. #strong[Abbildung @fig:basyx_web_ui_loaded];). Als primärer
visueller Indikator für einen erfolgreichen Start diente die
Weboberfläche, über die das zuvor erstellte AASX-Paket erfolgreich in
die Laufzeitumgebung geladen wurde, was durch die Anzeige der
#strong[SemiconductorX];-Verwaltungsschale bestätigt wurde.

#figure(image("../bilder/basyx_web_ui.png", width: 80%), caption: [
  Zielarchitektur der Datenpipeline vom Asset zum Client
])
<fig:basyx_web_ui_loaded>

Der entscheidende Test für die spätere Anbindung des Simulators war die
umfassende Überprüfung der HTTP/REST-Schnittstelle. Eine besonders
nützliche Ressource ist hierbei die interaktive Swagger-UI, die vom
AAS-Server unter “http:\/\/localhost:8081/swagger-ui/index.html“
bereitgestellt wird. Diese Weboberfläche dokumentiert alle verfügbaren
API-Endpunkte und ermöglicht deren direktes Testen im Browser (vgl.
#strong[Abbildung @fig:swagger-ui];). Um die grundsätzliche
Funktionalität des Lesezugriffs zu validieren, wurde eine beispielhafte
Testanfrage mittels “curl“ an den Server gesendet:

| curl -X ’GET’ ’http:\/\/localhost:8081/shells’ -H ’accept:
application/json’|

Der Server antwortete auf diese Anfrage erfolgreich mit einer
JSON-Repräsentation aller geladenen Verwaltungsschalen. Die vollständige
JSON-Antwort dieses Aufrufs ist im #strong[Anhang @appendix:getShells]
dokumentiert. Um den Schreibzugriff zu verifizieren, wurde zusätzlich
eine “PATCH“-Anfrage zum Modifizieren eines Druckwertes erfolgreich
durchgeführt. Diese Tests bestätigen, dass die AAS-Laufzeitumgebung voll
funktionsfähig ist und als stabile Basis für die nachfolgende Anbindung
des Drucksimulators dient.

#figure(image("../bilder/swagger-ui.png", width: 80%), caption: [
  Zielarchitektur der Datenpipeline vom Asset zum Client
])
<fig:swagger-ui>

== Test des Drucksimulators
<test-des-drucksimulators>
Die Verifikation des Drucksimulators konzentriert sich auf die korrekte
Umsetzung der zuvor konzipierten Logik und die funktionale Integration
in die Datenpipeline. Es ist an dieser Stelle explizit anzumerken, dass
das Ziel dieser Arbeit nicht die Erstellung eines physikalisch
validierten Simulationsmodells ist, da dies umfangreiche empirische
Messreihen erfordern würde, die außerhalb des Projektrahmens liegen. Die
konzipierten Wartungsszenarien wurden jedoch auf ihre Plausibilität hin
mit einem Praxispartner abgeglichen. Der Test verifiziert somit, ob der
Simulator die definierten Szenarien softwareseitig korrekt implementiert
und als dynamische Datenquelle für die AAS-Laufzeitumgebung fungieren
kann.

Die Überprüfung der internen Logik erfolgte über die grafische
Benutzeroberfläche (GUI) des Simulators. Durch das Aktivieren der
verschiedenen Wartungsszenarien, wie beispielsweise Rohrverstopfung,
wurde beobachtet, dass die Ist-Druckwerte für Pumpe und Abatement nicht
abrupt, sondern schrittweise an die neuen Soll-Werte angenähert wurden.
Dieses Verhalten belegt, dass die in #strong[Kapitel 4.4] beschriebene
Logik zur Nachbildung eines trägen Systemverhaltens erfolgreich
umgesetzt wurde.

Der entscheidende Schritt war die Validierung der Datenübertragung an
den AAS-Server, welche den Kernfokus dieses Tests darstellt. Nach dem
Start des Simulators und der Auswahl eines Szenarios wurde die
Weboberfläche der BaSyx-Laufzeitumgebung beobachtet. Es konnte
verifiziert werden, dass die Werte der Eigenschaften ‘ActualPressure‘ in
den jeweiligen ‘Operational Data‘-Teilmodellen in Echtzeit aktualisiert
wurden und exakt den im Simulator angezeigten Werten entsprachen. Wie in
#strong[Abbildung @fig:basyx_ui_live_update] zu sehen, entspricht der im
Simulator eingestellte Wert dem in der AAS-WebUI angezeigten Wert.

#figure(image("../bilder/basyx_ui_live_update.png", width: 80%), caption: [
  Gegenüberstellung Simulator und Verwaltungsschale Webansicht
])
<fig:basyx_ui_live_update>

Zusammenfassend lässt sich festhalten, dass die durchgeführten Tests die
primäre Funktion des Simulators im Kontext dieser Arbeit erfolgreich
nachweisen: Er dient als zuverlässiger, szenario-gesteuerter
Datenprovider. Die erfolgreiche und dynamische Aktualisierung der Werte
in den jeweiligen Verwaltungsschalen bestätigt die Funktionalität der
ersten Hälfte der konzipierten Datenpipeline – von der simulierten
Datenerzeugung bis zur standardisierten Repräsentation im Digitalen
Zwilling.
