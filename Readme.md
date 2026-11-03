# Typst Projekt für Wissenschaftliche Arbeiten

## Warum Typst?

- deterministischer als Word
- schneller als Latex (compilierzeit in `ms` statt `sek`/`min`)
- weniger Abhängigkeitsprobleme
- native Diagramm-Module
- funktionaler Aufbau (alles sind funktionen, die lokal oder global manipuliert werden können)
- ich mag RUST

- ! steilere Lernkruve


## About

Das ist ein Referenz-Projekt, auf dessen Grundlage meine Masterarbeit verfasst wird. 
Formatierungen und Layout gemäß der Richtlinien zum anfertigen wissenschaftlicher Arbeiten der HTW-Dresden. (zumindest größtenteils)

## Aufbau

- `main.typ` -> Einstiegspunkt
- `template.typ` -> Strucktur des Dokuments (Deckblatt, Abstract, Verzeichnisse, 'body', Literatur, Anhang und die Seitenzahlen usw...)
- `layout.typ` -> Formatierungen (Textgröße, Headings, Overrides,...)
- `meta.typ` -> Matadaten des Dokumentes (Autor, Gutachter, Daten, Martrikelnummer, ...) und Akronyme
- `anhang.typ \ inhalt.typ` -> includiren die Dateien aus den Ordnern 'content \ appendix' !muss manuell hinzugefügt werden! 
- `cover \ abstract.typ` -> selbsterklärend
- `utils/...typ` -> enthält hilfsfunktionen (für abkürzungen, tabelle-layouts, diagramme, ...), ! alle enthaltennen dateien müssen je einzeln `#import`iert werden. !
- `literatur.bib` -> sollte alle quellen in entsprechendem Format enthalten (z.b. mit Zotero exportieren)
- `appendix/files/` -> alle Dateien, die im Anhang hinzugefügt werden
- `appendix/...typ` -> includiert und formatiert die Dateien unter `appendix/files` für include in `anhang.typ`
- `images/` -> enthält alle Bilder (als PNG) oder Diagramme (als .typ gezeichnet mit fletcher -> typst modul für uml usw.) 

## Hinweis:
Die Richtlinien schreiben vor, dass nach einem Absatz 2 Leerzeilen sein sollen, wenn dannach eine Überschrift folgt...
Das habe ich nicht geschafft zu automatisieren. Es scheint ein Defizit von Typst zu sein.
Das muss manuell mit `#v(12pt)` eingefügt werden.
