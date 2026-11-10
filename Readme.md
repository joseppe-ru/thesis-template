# Typst Projekt für Wissenschaftliche Arbeiten

## Warum Typst?

- deterministischer als Word
- schneller als Latex (compilierzeit in `ms` statt `min`)
- weniger Abhängigkeitsprobleme
- community Plugins
- funktionaler Aufbau (alles sind Funktionen, die lokal oder global manipuliert werden können)
- ich mag RUST

- ! steilere Lernkruve


## About

Das ist ein Referenz-Projekt, auf dessen Grundlage meine Masterarbeit verfasst wird. 
Formatierungen und Layout gemäß der Richtlinien zum anfertigen wissenschaftlicher Arbeiten der HTW-Dresden. (zumindest größtenteils)

Die Strucktur der Dateien und Ordner sind von mir frei gewählt und stellen keinen Zwang dar. Ich finde es einfach nur Übersichtlicher, je größer das Projekt anwächst.

## Aufbau

- `main.typ` -> Einstiegspunkt, Orchestriert, Struktur des Projekts
- `layout.typ` -> Formatierungen (Textgröße, Headings, Overrides, ...)
- `meta.typ` -> Matadaten des Dokumentes (Autor, Gutachter, Daten, Martrikelnummer, ...) und Akronyme
- `anhang.typ \ inhalt.typ` -> inkludiren die Dateien aus den Ordnern 'content \ appendix' !muss manuell hinzugefügt werden! 
- `cover \ abstract.typ` -> selbsterklärend
- `policy.typ` -> ehrenwörtliche Erklärung
- `utils/...typ` -> enthält hilfsfunktionen (für abkürzungen, tabelle-layouts, diagramme, ...)
- `utils/lib.typ` -> enthält die imports für die Hilfsfunktionien (oder anderen nützlichen libraries)
- `literatur.bib` -> sollte alle Quellen in entsprechendem Format enthalten (z.b. mit Zotero BetterBibLaTex exportieren)
- `appendix/files/` -> alle Dateien, die im Anhang hinzugefügt werden
- `appendix/...typ` -> includiert und formatiert die Dateien unter `appendix/files` für include in `anhang.typ`
- `images/` -> enthält alle Bilder (als PNG) oder Diagramme (als .typ, gezeichnet mit fletcher -> typst modul für uml usw.) 

## Hinweis:

- Vor jedem Kapitel ab 2. Ordnung (Unterpunkt) muss eine Leerzeile eigefügt werden z.B. mit `#v(1em)`.
- Alle wesentlichen Inhalte befinden sich in Unterordnern (content, images, appendix) und müssen in den zugehörigen Dateien (`inhalt.typ`, `anhang.typ`, Bilder im Fließtext) manuell Inkludiert werden. 
- für alle Hilffunktionen aus `utils/` reicht am Anfang eines neuen Dokumentes der Import der `utils/lib.typ`.
- Tabellenlayouts sind nicht in `layout.typ` sondern über Funktionen aus `utils/tables.typ` abrufbar.

## How To Run?

1. Typst installieren
2. `corefonts` bzw. "Time New Roman" installieren
3. In der Konsole kompilieren
```bash
typst compile main.typ
typst watch main.typ
```
4. PDF öffnen (main.pdf)
