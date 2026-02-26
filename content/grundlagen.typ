#import "../utils.typ": *
= Grundlagen
<kap:grundlagen>
== Halbleiterfertigung: Die Subfab und ihre Prozesse
<kap:halbleiterfertigung-die-subfab-und-ihre-prozesse>
Die moderne Halbleiterfertigung, wie sie beispielsweise im
Halbleiterwerk von Bosch in Dresden betrieben wird, ist ein
Paradebeispiel für eine hochautomatisierte, datengetriebene
Produktionsumgebung im Sinne der Industrie 4.0. In diesen „Fabriken der
Zukunft“ werden immense Datenmengen generiert, um Prozesse mittels
künstlicher Intelligenz zu überwachen, zu steuern und zu optimieren. Ein
zentrales Merkmal dieser Fertigungsstätten ist die strikte räumliche und
funktionale Trennung zwischen dem Reinraum und der
unterstützenden Infrastruktur. @BoschHalbleiter

Im Reinraum finden die hochsensiblen Kernprozesse der Chipherstellung
statt. Dazu gehören unter anderem die Fotolithografie, Ätzprozesse sowie
diverse Beschichtungs- und Depositionsverfahren. Der Erfolg dieser
Schritte hängt von einer quasi perfekten Umgebung ab, die frei von
Partikeln, Vibrationen und anderen Störeinflüssen ist. Aus diesem Grund
wird die gesamte notwendige Versorgungsinfrastruktur in einen separaten
Bereich, die sogenannte Sub-Fab, ausgelagert.
@HilscherHalbleiterfertigung

Die Sub-Fab ist das maschinelle Rückgrat des Reinraums. Sie beherbergt
eine Vielzahl prozesskritischer Aggregate, darunter Stromversorgungen,
Kühl- und Heizsysteme sowie die für diese Arbeit zentralen Vakuumpumpen
und Abgasreinigungssysteme (Abatements). Die hohe Dichte an
energieintensiven Anlagen macht die Sub-Fab für einen erheblichen Teil,
teils bis zu 40%, des Gesamtenergieverbrauchs einer Fabrik
verantwortlich, was ihre betriebswirtschaftliche und ökologische
Relevanz unterstreicht. @SiliconSaxony

Die Vakuumpumpen spielen eine entscheidende Rolle, da viele der im
Reinraum ablaufenden Ätz- und Beschichtungsprozesse ein
prozessspezifisches Vakuum oder definierte Niederdruckbedingungen
erfordern. Diese kontrollierte Atmosphäre ist notwendig, um chemische
Reaktionen zu ermöglichen und Kontaminationen zu verhindern. Die Pumpen
evakuieren die Prozesskammern und fördern die dabei anfallenden
gasförmigen Nebenprodukte ab. Ihre Unterbringung in der Sub-Fab ist
essenziell, um die Übertragung von störenden Vibrationen auf die
Präzisionsanlagen im Reinraum zu verhindern.
@HilscherHalbleiterfertigung

Die abgepumpten Prozessgase sind häufig umwelt- oder
gesundheitsschädlich und dürfen nicht direkt in die Atmosphäre gelangen.
Sie werden daher den Abatement-Systemen zugeführt, die ebenfalls in der
Sub-Fab installiert sind. Diese Anlagen reinigen die Abgase durch
thermische, chemische oder physikalische Verfahren, bevor sie sicher
abgeleitet werden. @SiliconSaxony

Die zuverlässige Funktion der Kette aus Prozessanlage, Vakuumpumpe und
Abatement-System ist für einen stabilen Produktionsablauf unerlässlich.
Ein Ausfall in diesem Versorgungspfad kann zum sofortigen Stillstand der
betroffenen Produktionsmaschinen führen. Die Analyse von Betriebsdaten
dieser Aggregate zur vorausschauenden Wartung (Predictive Maintenance)
und zur Erkennung von Anomalien ist daher ein zentraler Hebel zur
Steigerung der Gesamtanlageneffektivität und zur Reduzierung
ungeplanter Stillstände. @HilscherHalbleiterfertigung

== Industrie 4.0 und der Digitale Zwilling
<kap:industrie-4.0-und-der-digitale-zwilling>
Die Vision der Industrie 4.0 zielt auf die Schaffung intelligenter,
flexibler und weitgehend selbstorganisierter Produktionssysteme ab. Eine
Grundvoraussetzung hierfür ist die lückenlose digitale Vernetzung aller
an der Wertschöpfung beteiligten Akteure und Objekte – von der einzelnen
Maschine bis zur gesamten Fabrik. @PlattformI40

Der Digitale Zwilling ist ein umfassendes, virtuelles Abbild eines
konkreten physischen Objekts oder sogar eines immateriellen Prozesses,
das dynamisch mit seinem realen Gegenstück über dessen gesamten
Lebenszyklus hinweg gekoppelt ist. Er ist somit weit mehr als nur ein
statisches digitales Modell. Ein Kernaspekt des Digitalen Zwillings ist
die Integration und Bündelung sämtlicher relevanter Informationen und
Daten an einem zentralen, digital zugänglichen Ort. Dazu gehören sowohl
statische Daten wie technische Spezifikationen und Dokumentationen als
auch dynamische Betriebsdaten, die in Echtzeit von Sensoren aus der
physischen Welt erfasst werden und den aktuellen Zustand des Assets
widerspiegeln. @FraunhoferPublication

Die wahre Stärke und Bedeutung des Digitalen Zwillings für die Industrie
4.0 entfaltet sich durch seine Fähigkeit, nicht nur die Vergangenheit
und Gegenwart eines Assets abzubilden, sondern auch dessen zukünftiges
Verhalten zu simulieren. Durch die Einbettung von Verhaltensmodellen
ermöglicht er die Analyse von Was-wäre-wenn-Szenarien, die virtuelle
Inbetriebnahme von Anlagen oder die prädiktive Vorhersage von
Wartungsbedarfen. Er wird somit zur informationstechnischen Grundlage,
die es erlaubt, Produktionsprozesse zu überwachen, zu analysieren und zu
optimieren, ohne direkt in den laufenden physischen Betrieb eingreifen
zu müssen. Indem der Digitale Zwilling eine einheitliche und
herstellerübergreifende Datengrundlage schafft, löst er Inselsysteme auf
und wird zum entscheidenden Wegbereiter für Interoperabilität
und datengetriebene Wertschöpfung in der intelligenten Fabrik der
Zukunft.

== Die Verwaltungsschale (Asset Administration Shell) als Standard
<kap:die-verwaltungsschale-asset-administration-shell-als-standard>
Während der Digitale Zwilling das übergeordnete, konzeptionelle Leitbild
für die umfassende digitale Repräsentation eines Assets darstellt,
bedarf es für dessen praktische Umsetzung in der Industrie 4.0 einer
konkreten, herstellerübergreifenden Spezifikation. Diese standardisierte
Implementierung des Digitalen Zwillings ist die Verwaltungsschale @salari_asset_2019. Ihre
Entwicklung wird maßgeblich von der Plattform Industrie 4.0 und der #short("IDTA") vorangetrieben, um eine zentrale Herausforderung der Digitalisierung zu
lösen: die Interoperabilität. Die #short("AAS") schafft eine einheitliche digitale
Sprache, die es Komponenten, Geräten und Anwendungen ermöglicht, über
Unternehmens-, Branchen- und Ländergrenzen hinweg nahtlos zu
kommunizieren.

Das Grundprinzip der Verwaltungsschale lässt sich am besten mit der
Analogie eines digitalen Karteikartensystems beschreiben. Die #short("AAS") selbst
ist der Kasten mit genormter Größe, der alle Informationen zu einem
spezifischen Asset – beispielsweise einer Vakuumpumpe – enthält. Die
einzelnen thematisch sortierten Karteikarten in diesem Kasten sind die
Teilmodelle (engl. Submodels). So gibt es beispielsweise ein
Teilmodell für technische Daten, eines für die Dokumentation und ein
weiteres für operative Live-Daten. Diese Struktur wird durch ein
übergeordnetes Metamodel formal definiert. Das Metamodell ist der Satz
von fundamentalen Gestaltungsregeln, der festlegt, aus welchen
Bausteinen eine jede #short("AAS") bestehen muss, welche Eigenschaften diese
Bausteine haben und wie sie zueinander in Beziehung stehen. Die
zentralen Bausteine sind dabei die #short("AAS") selbst, die zugehörigen
Teilmodelle und die darin enthaltenen Teilmodellelemente (engl.
SubmodelElements), welche die eigentlichen Datenpunkte als
Eigenschaften, Operationen oder Dateien mit definierten Datentypen
repräsentieren. @Metamodel)

Ein entscheidender Aspekt für die Skalierbarkeit und
Wiederverwendbarkeit ist die Unterscheidung zwischen Typen und
Instanzen. Ein Asset kann als Typ (z. B. das generische Pumpenmodell
eines Herstellers) oder als Instanz (die spezifische Pumpe mit der
Seriennummer XYZ) existieren. Analog dazu werden für Teilmodelle
Templates definiert. Ein solches Template agiert wie ein
standardisiertes, vorgedrucktes Formular oder ein Datenbankschema. Es
gibt die Struktur, die Bezeichner und die Semantik für ein bestimmtes
Teilmodell, wie z.B. ein \"Digitales Typenschild\", verbindlich vor. Ein
Hersteller, der die Daten seiner Pumpe digital bereitstellen möchte,
\"füllt\" dieses Template aus und erzeugt damit eine Teilmodell-Instanz.
Dieser Mechanismus stellt sicher, dass alle digitalen Typenschilder,
unabhängig vom Hersteller, die gleiche Struktur aufweisen und somit
maschinell interoperabel sind. @bader_details_2019

Die Sicherheit und die Kontrolle über die bereitgestellten Daten sind im
industriellen Kontext von höchster Priorität. Die #short("AAS")-Spezifikation
trägt dem Rechnung, indem sie ein Sicherheitskonzept integriert, das auf
#short("ABAC") basiert. Dieses Modell
ermöglicht es, sehr granulare Zugriffsrechte zu definieren und somit
präzise zu steuern, welcher Partner welche Informationen innerhalb einer
Verwaltungsschale einsehen oder verändern darf. @bader_details_2019

Der letztendliche Verwendungszweck der Verwaltungsschale ist die
Schaffung einer durchgängigen, digitalen Interoperabilität über den
gesamten Lebenszyklus eines Assets hinweg – von der Planung und dem
Engineering über den Betrieb und die Wartung bis hin zum Recycling.
Indem sie eine einheitliche, semantisch reichhaltige und
maschinenlesbare Datengrundlage bietet, ermöglicht die #short("AAS") den nahtlosen
Informationsaustausch zwischen verschiedenen Unternehmen einer
Wertschöpfungskette und wird so zum zentralen Wegbereiter für die
flexiblen und datengetriebenen Geschäftsmodelle der Industrie 4.0.

== Der Eclipse Dataspace Connector
<kap:der-eclipse-dataspace-connector>
Während die Verwaltungsschale das #emph[Was] – also die standardisierte
Struktur und Semantik – des Digitalen Zwillings definiert, adressieren
Datenraumtechnologien das #emph[Wie] des Datenaustauschs. Die
fortschreitende Vernetzung im Rahmen von Industrie 4.0 erfordert einen
unternehmensübergreifenden Datenaustausch, der jedoch auf einer
fundamentalen Prämisse beruhen muss: der Datensouveränität. Jeder
Teilnehmer eines Datenökosystems muss zu jeder Zeit die vollständige
Kontrolle darüber behalten, wer auf seine Daten zugreift und unter
welchen Bedingungen diese genutzt werden dürfen. Die technische
Umsetzung solcher souveränen, dezentralen Datenräume wird maßgeblich
durch Initiativen wie die #short("IDSA") @InternationalDataSpaces vorangetrieben.

Der #short("EDC") ist ein
Open-Source-Framework, das als technisches Kernstück zur Realisierung
solcher Datenräume dient. @EclipseEDC Er implementiert die Protokolle
und Mechanismen, die für einen sicheren und souveränen Datenaustausch
zwischen Teilnehmern notwendig sind, ohne dass eine zentrale Plattform
erforderlich wäre. Die Architektur des #short("EDC") basiert auf der strikten
Trennung von zwei Ebenen: der Kontroll- und der Datenebene
(#emph[Control Plane] und #emph[Data Plane];) @EclipseEDCArchitecture.

Auf der Kontrollebene finden alle vorbereitenden und
administrativen Prozesse statt. Hierzu gehört das Aushandeln von
Verträgen. Ein datennutzender Teilnehmer (Konsument) fragt die
verfügbaren Datenangebote eines Datenanbieters ab. Jedes Angebot ist mit
einer maschinenlesbaren Nutzungsrichtlinie (#emph[Usage Policy];)
verknüpft. In einem automatisierten Verhandlungsprozess einigen sich die
Konnektoren beider Teilnehmer auf einen digitalen Vertrag, der die
genauen Nutzungsbedingungen festlegt. Erst nach erfolgreichem
Vertragsabschluss wird die Datenebene für den eigentlichen
Transfer aktiviert.

Dieser Mechanismus stellt sicher, dass kein Datentransfer ohne
explizite, regelbasierte Zustimmung erfolgt, wodurch die
Datensouveränität des Anbieters technisch durchgesetzt wird. Für das in
dieser Arbeit untersuchte Szenario ist der #short("EDC") somit die
Schlüsseltechnologie, um den Austausch von Verwaltungsschalen – als
Träger der wertvollen Pumpen- und Abatement-Daten – zwischen
Halbleiterfabrik und Equipmenthersteller zu ermöglichen. Die #short("AAS")
definiert den Inhalt und die Struktur des auszutauschenden Digitalen
Zwillings, während der #short("EDC") den sicheren und kontrollierten
\"Transportcontainer\" für diesen Austausch bereitstellt und somit die
souveräne Zusammenarbeit in einem verteilten industriellen Ökosystem
realisiert.
