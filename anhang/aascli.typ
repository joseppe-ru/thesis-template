= Logs des AAS Clients
<appendix:aasclilog>


// #raw(read("files/aascli.log"), lang: "txt")
// 1. Schriftgröße für Logs verkleinern (spart Platz)
// #show raw: set text(size: 8pt)

// 2. Den "Zero-Width-Space" Trick anwenden
// #show raw: it => {
// Fügt nach jedem Zeichen ein unsichtbares Umbruchszeichen ein
// show regex("."): char => char + sym.zws
// it
// }

// 3. Datei ganz normal laden
// #raw(read("files/aascli.log"), lang: "txt")


#[
  // 1. Schriftgröße anpassen
  #show raw: set text(size: 8pt)

  // 2. Datei als reinen Text (String) einlesen
  #let log-text = read("files/aascli.log")

  // 3. String-Manipulation: Den Text in einzelne Zeichen (clusters) zerlegen
  // und mit dem unsichtbaren Leerzeichen (sym.zws) wieder zusammenkleben.
  // Das passiert nur im Arbeitsspeicher und baut keine Layout-Bäume!
  #let wrapped-text = log-text.clusters().join(sym.zws)

  // 4. Den fertig manipulierten String in den raw-Block übergeben
  #raw(wrapped-text, lang: "txt")
]
