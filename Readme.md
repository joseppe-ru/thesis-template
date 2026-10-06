# Typst Projekt für Wissenschaftliche Arbeiten

## Aufbau


- `main.typ` -> Einstiegspunkt
- `template.typ` -> Strucktur des Dokuments (Deckblatt, Abstract, Verzeichnisse, 'body', Literatur, Anhang und Die seitenzahlen usw...)
- `layout.typ` -> Farmatierungen (Textgröße, Overrides,...)
- `meta.typ` -> Matadaten des Dokumentes (Autor, Gutachter, Daten, Martrikelnummer, ...) und Akronyme
- `anhang.typ \ inhalt.typ` -> includiren die Dateien aus den Ordnern 'content \ appendix' !muss manuell hinzugefügt werden! 
- `cover \ abstract.typ` -> selbsterklärend
- `utils/...typ` -> enthält hilffunktionen (für abkürzungen, tabelle-layouts, diagramme, ...), ! alle enthaltennen dateien müssen je einzeln `#import`eirt werden. !
- `literatur.bib` -> sollte alle quellen in entsprechendem Format enthalten (irgendwie mit Zotero exportiert)
- `appendix/files/` -> alle Dateien, im Anhang hinzugefügt werden
- `appendix/...typ` -> includiert und formatiert die Dateien unter `files` zum import in `anhang.typ`
- `images/` -> enthält alle Bilder (als PNG) oder Diagramme (als .typ gezeichnet mit fletcher -> typst modul für uml usw.) 

