#import "meta.typ": meta
#import "@preview/hydra:0.6.2": hydra

#let layout(body) = {

  // --- Metadaten ---
  // =================
  set document(title: meta.title, author: meta.author)


  // --- Seitenlayout ---
  // ====================
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 2cm),
    header-ascent: 1.25cm,
    footer-descent: 1.25cm, 
    numbering: "I",
    number-align: right,
    header: context {
      set text(size: 10pt,bottom-edge: "descender") // Kopfzeile 10 Pkt.
      block[
        #hydra(1)
        #line(length: 100%, stroke: 0.5pt + black) // Waagerechter Strich
      ]
    },
    footer: context {
      set text(size: 12pt)
      set align(right)
      counter(page).display(page.numbering)
    }
  )


  // --- Typografie ---
  // ==================
  let body-font = "Times New Roman"
  set text(font: body-font, size: 12pt, lang: "de")
  set par(justify: true, leading: 12pt, linebreaks: "optimized")
  show par: it => {
    v(24pt, weak:true)
    it
    v(24pt, weak:true)
  }


  // --- Inhaltsverzeichnis ---
  // ==========================
  show outline.entry.where(level: 1): it => {
    v(1em, weak: true) 
    strong(it)
  }


  // --- Überschriften --- 
  // =====================
  set heading(numbering: "1.1", supplement: [Kapitel])
  // Ebene 1
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "bold")
    // set block(below: 24pt, above:24pt)
    // it
    it
  }
  // Ebene 2
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    // set block(below: 24pt, above:24pt)
    // it
    v(12pt, weak:false)
    it
  }
  // Ebene 3
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    // set block(below: 24pt, above:24pt)
    // it
    v(12pt, weak:false)
    it
  }
  // Ebene 4
  show heading.where(level: 4): it => {
    set text(size: 12pt, weight: "regular", style: "italic")
    // set block(below: 24pt, above:24pt)
    // it
    v(12pt, weak:false)
    it
  }


  // --- Referenzen ---
  // ==================
  show ref: it => {
    let label-str = str(it.target)

    if (
      label-str.starts-with("fig:")
        or label-str.starts-with("tab:")
        or label-str.starts-with("appendix:")
        or label-str.starts-with("kap:")
    ) {
      strong(it)
    } else {
      it
    }
  }


  // --- Tabellen und Bilder ---
  // ===========================
  // => Abbildungen
  show figure.caption: set text(size: 10pt)
  show figure.caption: set align(left)
  show figure.where(kind: image): set figure(supplement: [Abbildung])
  show figure.where(kind: image): it => {
    set block(above: 1.2em, below: 1.2em)
    it
  }
  // => Tabellen
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Tabelle])
    set table(
      fill: (x, y) => if y == 0 { rgb("BDC1D0") },
      inset: (right: 1.5em),
    )
    show table.cell: it => {
      if it.y == 0 {
        set text(black)
        strong(it)
      } else if it.body == [] {
        pad(..it.inset)[_N/A_]
      } else {
        it
      }
    }  
  // Rahmen zeichnen
  show figure.where(kind: image): fittich => {
    set figure(gap: 0pt)
    block[
      #rect(stroke: 1pt, inset: 1pt)[#fittich.body]
      #v(-1em)
      #fittich.caption
    ]
  }


  // --- Gleichungen ---
  // ===================
  set math.equation(numbering: "(1)")
  show math.equation: set block(above: 1.2em, below: 1.2em)
  show math.equation: set text(weight: 400)


  body
}
