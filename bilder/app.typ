#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "../utils.typ": *

// #figure(
//   diagram(
//     spacing: 3cm,
//
//     uml-interface((0, 0), [IAsset], meth: [\+ getId(): String \ \+ getStatus(): Status], name: <iasset>),
//     uml-class((0, 1), [Pumpe], attr: [\- druck: float \ \- rpm: int], meth: [\+ start() \ \+ stop()], name: <pumpe>),
//     record((1, 1), label: [AssetStatus], name: <status>),
//
//
//     edge(<pumpe>, <iasset>, "-|>", stroke: (dash: "dashed")),
//     edge(<pumpe>, <status>, "->", label: [has a], label-pos: 0.5, label-side: right),
//   ),
//   caption: [UML-Klassendiagramm des Asset-Modells],
// )
//


#figure(
  [
    #show table: it => text(weight: "thin")[#it]
    #set text(weight: "regular", size: 10pt)
    #diagram(
      // Etwas größerer Abstand, da die UML-Boxen durch die Methoden breiter sind
      spacing: (1cm, 1cm),

      // --- Nodes ---
      // Konfiguration
      record((2, 1), [EndpointRecord], name: <config>),

      // Main & Watcher
      uml-class((1, 1), [Application], meth: [\+ main(args: String\[\])], name: <main>, width: 2.5cm),

      uml-class(
        (0, 1),
        [PressureWatcher],
        attr: [\- running: boolean \ \- provider: PressureProvider \ \- endpoints: EndpointRecord \ \- listeners: List<PressureListener>],
        meth: [\+ addListener(l: PressureListener) \ \+ run() \ \- notifyListeners(r: PressureRecord)],
        name: <watcher>,
        width: 6cm,
      ),

      // Strategy Pattern (Provider)
      uml-interface(
        (1, 0),
        [PressureProvider],
        meth: [\+ getPressure(e: EndpointRecord): \ PressureRecord],
        name: <provider>,
      ),

      uml-class(
        (0, 0),
        [BaSyxPressureProvider],
        meth: [\+ getPressure(e: EndpointRecord): \ PressureRecord],
        name: <basyx>,
        // width: 4cm,
      ),

      uml-class(
        (2, 0),
        [EDCPressureProvider],
        meth: [\+ getPressure(e: EndpointRecord): \ PressureRecord],
        name: <edc>,
      ),

      // Observer Pattern (Listener)
      uml-interface((1, 2), [PressureListener], meth: [\+ onNewPressureData(data: PressureRecord)], name: <listener>),

      uml-class((0, 2), [PressureAnalyser], meth: [\+ onNewPressureData(data: PressureRecord)], name: <analyser>),

      uml-class(
        (2, 2),
        [CsvWriter],
        attr: [\- path: Path \ \- MAX_FILE_SIZE: long],
        meth: [\+ onNewPressureData(data: PressureRecord) \ \- formatPressureData(...) \ \- writeToFile(text: String)],
        name: <writer>,
      ),

      // --- Edges ---
      // Main zu Watcher und Config
      edge(<main>, <config>, "->", label: [lädt via Builder], label-side: left),
      edge(<main>, <watcher>, "->", label: [startet \ Thread], label-side: right),

      // Config Injection
      edge(
        <config>,
        <provider>,
        "->",
        stroke: (dash: "dashed"),
        label: [steuert Instanziierung],
        label-pos: 0.2,
        label-side: right,
      ),

      // Strategy Abhängigkeiten
      edge(<watcher>, <provider>, "->", label: [nutzt], label-side: right),
      edge(<basyx>, <provider>, "-|>", stroke: (dash: "dashed")),
      edge(<edc>, <provider>, "-|>", stroke: (dash: "dashed")),

      // Observer Abhängigkeiten
      edge(<watcher>, <listener>, "->", label: [benachrichtigt], label-side: right),
      edge(<analyser>, <listener>, "-|>", stroke: (dash: "dashed")),
      edge(<writer>, <listener>, "-|>", stroke: (dash: "dashed")),
    ),
  ],
  caption: [Klassendiagramm der Client-Applikation],
)
<fig:classapp>

