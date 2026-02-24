// #import "@preview/acrostiche:0.7.0": *
#import "../utils.typ": *
= Einleitung
<einleitung>
== Motivation
<motivation>
Der Halbleiterproduktionsprozess stellt besonders hohe Anforderungen an
seine Prozessumgebungen, weshalb Frontend Fabriken von
Halbleiterherstellern als Reinraum aufgebaut sind. Sie bestehen aus drei
Ebenen: dem Reinraum mit den Prozess- und Messmaschinen auf mittlerer
Ebene, der Sub-Fab mit Maschinen und Anlagen zur Aufbereitung von
Reinstwasser, Abgasreinigung und Maschinenmedienversorgung über und
unter dem Reinraum.

Bei den Produktionsprozessen fallen verschiedene Abgase und
Prozesschemikalien an, die nicht direkt in die Umgebung abgegeben werden
dürfen. Die Abgase entstehen typischerweise in Prozesskammern (z.B. Ätz-
oder Implantationsanlagen). Diese Gase müssen sicher aus dem Reinraum
entfernt und in der SubFab in einem Abatement-System
(Gasreinigungssystem) behandelt werden. Spezielle Vakuumpumpen saugen
die Gase ab, da viele Prozesse unter Unterdruck stattfinden. Die Pumpen
sind oft ebenfalls in den SubFab-Bereich verlagert, um Vibrationen und
Partikelemissionen im Reinraum zu minimieren. Das Abatement-System
reinigt die Abgase durch verschiedene Verfahren, abhängig von der
Zusammensetzung der Schadstoffe (z.B. durch Thermische Oxidation oder
per Nasswäscher). Nach der Reinigung werden die neutralisierten Abgase
sicher in die Abluftanlage der Fabrik abgeleitet.

Die Zuverlässigkeit von Vakuumpumpen und Abatement-Systemen ist daher
essenziell für stabile Produktionsprozesse. Unerkannter Verschleiß an
Pumpen oder verstopfte Zuleitungen zum Abatement können die Produktion
beeinträchtigen. Die Druckverhältnisse in beiden Systemen bestimmt die
Effizienz des Abgastransports. Wartungsbedarfe frühzeitig zu erkennen,
ermöglicht nicht nur Kosteneinsparungen, sondern minimiert auch
ungeplante Stillstände. Durch einen kontinuierlichen Abgleich von
Druckwerten (Solldruck der Pumpe, Druck am Ausgang der Pumpe und Druck
am Abatement) lassen sich Rohrverschmutzungen erkennen und Rückschlüsse
auf den Gesundheitszustand von Pumpen ziehen. Aktuell können diese
Messwerte nur direkt an den Geräten in der SubFab abgelesen werden. Das
bedeutet, dass Wartungstechniker regelmäßig vor Ort Messungen
durchführen und Anomalien manuell identifizieren müssen. Diese
zeitaufwändige reaktive Wartung erlaubt jedoch keine kontinuierliche,
vorausschauende Diagnose (Predictive Maintenance) mit optimierten
Wartungsempfehlungen, wie es durch einen direkten Zugriff des
Equipmentherstellers per Ferndiagnose möglich wäre.

Im Rahmen des FuE-Seminars soll untersucht werden, inwieweit
strukturierte Daten aus dem Sub-Fab Bereich einer Halbleiterfabrik zur
Remote-Überwachung von Prozessen genutzt werden können, um und proaktive
Wartungsempfehlungen zu geben. Hierbei steht die Integration von
Digitalen Zwillingen auf Basis der AAS im Fokus. Die AAS ermöglicht eine
standardisierte hierarchische Beschreibung von digitalen Zwillingen. Mit
dem EDC können Daten, wie auch AAS, in einem gemeinsamen Datenraum
zugänglich gemacht werden. Der Fokus bei dieser Form des
Datenaustausches liegt auf der Souveränität der Daten und der damit
verbundenen Kontrolle des Datenanbieters über seine Daten.

== Aufgabenstellung
<aufgabenstellung>
=== Allgemein
<allgemein>
Die übergeordnete Zielsetzung dieser Forschungsarbeit ist die Integration und der souveräne Austausch von Equipmentdaten – spezifisch von Vakuumpumpen und Abatement-Systemen – zur kontinuierlichen Überwachung und Wartungsoptimierung in der Halbleiterfertigung. Der Forschungs- und Implementierungsaufwand dieses Vorhabens erstreckt sich über zwei konsekutive Projektphasen, beginnend im Sommersemester 2025 bis zum Abschluss im Wintersemester 2025/2026.
Die vorliegende Forschungsarbeit führt beide Erarbeitungsstände in einer Gesamtdarstellung zusammen. Im Kern soll untersucht werden, wie die #short("AAS") als standardisierter Digitaler Zwilling und der #short("EDC") für einen sicheren Datenaustausch genutzt werden können, um die informationstechnische Lücke zwischen dem Fabrikbetreiber und dem Equipmenthersteller zu schließen.


=== SomerSemester 2025
<somersemester-2025>
Die erste Phase dieses Forschungsvorhabens legt die technologische und konzeptionelle Grundlage für die
gesamte Datenpipeline. Der Schwerpunkt liegt auf der Erstellung einer
validen, standardisierten und dynamischen Datengrundlage. Dies umfasst
zunächst eine fundierte Einarbeitung in die relevanten Technologiefelder
der Halbleiterproduktion, der Asset Administration Shell und des Eclipse
Dataspace Connectors.

Auf dieser Wissensbasis erfolgt die Konzeption und Erstellung
von AAS-Modellen für eine Vakuumpumpe und ein Abatement-System. Die
Modellierung soll dabei möglichst umfangreich sein, um die Assets
detailliert abzubilden. Ein zentrales Element ist die Erstellung eines
Konzepts zur Bereitstellung der für die Wartungsanalyse entscheidenden
Druckwerte. Konkret müssen die folgenden drei Werte über die
Verwaltungsschalen zugänglich gemacht werden: der Solldruck der
Pumpe, der tatsächlich erreichte Druck an ihrem Ausgang sowie
der Druck am Eingang des nachgeschalteten Abatement-Systems.
Die Differenz und das Verhalten dieser Werte zueinander bilden die
informationstechnische Basis für die spätere Fehlerdiagnose.

Um eine realitätsnahe Datengrundlage für die Analyse zu schaffen, wird
parallel ein Druck-Simulator entwickelt. Dessen Aufgabe ist
die Modellierung und Validierung verschiedener Wartungsszenarien. Der
Simulator muss das Druckverhalten in Abhängigkeit von Faktoren wie
Verschmutzung, Durchfluss und Pumpenleistung abbilden können.
Insbesondere sollen Szenarien für typische Störfälle wie Pumpenausfälle
und Rohrverstopfungen modelliert werden. Dies schließt den normalen
Betrieb, eine allmähliche Verschmutzung, eine plötzliche Blockade sowie
einen abrupten Pumpenausfall oder Druckabfall mit ein. Die

Implementierung dieser Komponenten und die Verfassung der vorliegenden
wissenschaftlichen Dokumentation bilden den Abschluss dieser ersten
Projektphase.

=== Wintersemester 2025/26
<wintersemester-2025-26>
Aufbauend auf den technologischen Grundlagen der ersten Projektphase verlagert sich der Fokus im Wintersemester 2025/2026 auf den systemübergreifenden Datentransfer sowie den Aufbau einer nachgelagerten Client-Infrastruktur. Ein zentrales Ziel ist die Implementierung einer prototypischen Datenpipeline, welche den souveränen Datenaustausch zwischen der Halbleiterfabrik und dem Equipmenthersteller innerhalb eines verteilten Datenraums realisiert. Im Fokus steht dabei die Integration des #short("EDC") der als HTTP-Proxy fungiert, um die sichere Kommunikation sowie die notwendige Vertragsaushandlung informationstechnisch abzubilden.

Um die über den EDC bereitgestellten Verwaltungsschalen datenökonomisch zu verwerten, bedarf es der Entwicklung einer dedizierten Client-Anwendung. Diese Applikation hat die Aufgabe, die kontinuierlich aktualisierten Druckwerte aus der BaSyx-Umgebung über den Datenraum strukturiert abzurufen. Zur Gewährleistung der Nachvollziehbarkeit und für weiterführende Inspektionen sollen die extrahierten Zeitreihendaten persistiert und für eine Dashboard-gestützte, visuelle Aufbereitung zugänglich gemacht werden.

Den analytischen Abschluss dieser Projektphase bildet die Evaluation der generierten Druckdifferenzen. Anstelle einer hochkomplexen maschinellen Lernmethode liegt der Schwerpunkt hierbei auf dem Entwurf und der Implementierung einer deterministischen, schwellwertbasierten Analyse-Schnittstelle innerhalb des Clients. Durch diese regelbasierte Auswertung sollen spezifische Anomalien und Fehlermuster grundlegend klassifiziert werden, um die prinzipielle Machbarkeit der prädiktiven Wartung (Predictive Maintenance) zu validieren. Das finale Ziel ist somit der Proof of Concept der gesamten informationstechnischen Wirkkette – von der simulierten Datengenerierung über den souveränen Datentransfer bis hin zur regelbasierten Zustandsbewertung am Endpunkt.


== Aufbau der Arbeit
<aufbau-der-arbeit>
Die vorliegende wissenschaftliche Arbeit ist in sechs Kapitel
gegliedert, die den Leser systematisch von der Problemstellung über die
theoretischen Grundlagen und die Konzeption bis hin zur praktischen
Implementierung und deren Überprüfung führen.

#strong[@grundlagen] legt das theoretische Fundament zum Verständnis der
Arbeit. Es werden zunächst die prozesstechnischen Besonderheiten der
Halbleiterfertigung mit Fokus auf die Sub-Fab erläutert. Anschließend
werden die Kernkonzepte von Industrie 4.0, des Digitalen Zwillings und
dessen standardisierter Implementierung durch die #short("AAS") vorgestellt. Abgeschlossen wird das Kapitel mit einer
Einführung in den #short("EDC") als Technologie für
einen souveränen Datenaustausch.

Aufbauend auf diesen Grundlagen wird in #strong[@konzeption] das
spezifische Lösungskonzept für die Aufgabenstellung entwickelt. Dies
umfasst den Entwurf der informationstechnischen Zielarchitektur, die
Herleitung des Simulationsansatzes zur Generierung der Druckdaten sowie
die Begründung für die Auswahl von Eclipse BaSyx als
Implementierungs-Framework. Das Kapitel schließt mit dem detaillierten
Entwurf des AAS-Modells für die Pumpe und das Abatement-System.

#strong[@implementierung] dokumentiert die praktische Umsetzung des entworfenen
Konzepts. Die einzelnen Schritte, von einer Untersuchung der
Datenraum-Konnektivität über den Aufbau der AAS-Laufzeitumgebung bis hin
zur konkreten Erstellung der Verwaltungsschalen und der Realisierung und
Anbindung des Drucksimulators, werden hier detailliert beschrieben.

Die Verifikation der entwickelten Komponenten ist Gegenstand von
#strong[@tests-und-ergebnisse];. Hier werden die durchgeführten Funktionalitätstests
der AAS-Laufzeitumgebung sowie die Überprüfung des Drucksimulators und
seiner erfolgreichen Datenübertragung in die Verwaltungsschale dargelegt
und die Ergebnisse präsentiert.

Abschließend fasst #strong[@fazit-und-ausblick] die Arbeit zusammen, reflektiert
die erzielten Ergebnisse im Kontext der ursprünglichen Aufgabenstellung
und gibt einen Ausblick auf die weiterführenden Arbeiten im kommenden
Semester, welche die vollständige Realisierung der Datenpipeline und die
KI-gestützte Analyse umfassen werden.
