= Fazit und Ausblick
<fazit-und-ausblick>
Die vorliegende Arbeit adressierte die Herausforderung der
ineffizienten, reaktiven Wartung von prozesskritischen Anlagen in der
Sub-Fab von Halbleiterfabriken. Ausgehend von der Problemstellung, dass
relevante Betriebsdaten von Vakuumpumpen und Abatement-Systemen oft nur
manuell vor Ort auslesbar sind, wurde ein Konzept für einen
standardisierten und datensouveränen Informationsaustausch entwickelt,
um die Grundlagen für prädiktive Wartungsstrategien zu schaffen. Das
Kernziel war die Realisierung der ersten Hälfte einer prototypischen
Datenpipeline, die von der Datenerfassung am Asset bis zu dessen
standardisierter Repräsentation im Digitalen Zwilling reicht.

Im Rahmen der Konzeption und Implementierung konnten die in der
Aufgabenstellung für das erste Semester formulierten Ziele erfolgreich
umgesetzt werden. Es wurde eine voll funktionsfähige
AAS-Laufzeitumgebung auf Basis von Eclipse BaSyx aufgebaut und die
Verwaltungsschalen für eine Vakuumpumpe und ein Abatement-System unter
Verwendung von Standard-Templates und anwendungsspezifischen
Teilmodellen modelliert. Ein zentraler Meilenstein war die Entwicklung
eines prozessbasierten Drucksimulators in Python, der in der Lage ist,
Daten für eine Reihe von Wartungsszenarien – vom Optimalbetrieb über
schleichende Rohrverschmutzung bis hin zum akuten Pumpendefekt – zu
generieren. Die erfolgreiche Anbindung dieses Simulators an den
AAS-Server über eine REST-API demonstriert eindrücklich die
Kernfunktionalität der konzipierten Architektur: die echtzeitnahe
Aktualisierung eines standardisierten Digitalen Zwillings mit
Live-Betriebsdaten. Damit wurde der Nachweis erbracht, dass eine valide
Datengrundlage für weiterführende Übertragungen und Analysen
bereitgestellt werden kann.

Die Ergebnisse dieser Arbeit bilden eine robuste Grundlage für die im
zweiten Semester anstehenden Aufgaben. Die nun verfügbare,
datengestützte AAS-Infrastruktur ist die Voraussetzung für den nächsten
Schritt: die Implementierung der vollständigen Datenpipeline unter
Einbeziehung des Eclipse Dataspace Connectors. Der Fokus wird darauf
liegen, die erstellten Verwaltungsschalen über einen souveränen
Datenraum einem externen Akteur – dem Equipmenthersteller – kontrolliert
zur Verfügung zu stellen. Die vom Simulator generierten,
szenario-spezifischen Daten werden anschließend als Trainings- und
Validierungsdatensatz für die Entwicklung einer KI-gestützten Analyse
der Druckdifferenzen dienen. Das finale Ziel bleibt die Ableitung
konkreter, proaktiver Wartungsempfehlungen, um die Vision einer
datengetriebenen Instandhaltung in der Halbleiterfertigung zu
realisieren.
