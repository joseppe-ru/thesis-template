#import "meta.typ": meta

#import "utils/lib.typ":*


#set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 3cm, right: 3cm),
    header-ascent: 1.25cm,
    footer-descent: 1.25cm, 
    numbering: none,
    number-align: right,
    header: context {},
    footer:context {},
)

#v(1cm)
#align(center, image("images/htw_logo.svg", width: 40%))

#v(5mm)
#align(center, text(1.5em, weight: 700, meta.degree))

#v(15mm)

// // #align(center, text(2em, weight: 700, meta.title))
//
// #show heading.where(level: 1): it => {
//     set text(size: 2em, weight: 700)
//     it
// }
#align(center)[
  #set text(size: 2em, weight: 700)
  #heading(meta.title) <no-break>
]

#v(5cm)
#align(center)[
  #align(left, 

  fmt_table(kind: tbl.cover, outlined:false, caption:none, columns:(1fr,1fr),
    ..(
      "Vorgelegt von:", meta.author,
      "Studienbereich:", meta.faculty,
      "Vorgelegt am:", meta.submissionDate.display("[day].[month].[year]"),
      "Ort:", meta.City,
      "Matrikelnummer:", meta.MatrikelNumber,
      "Erstgutachter:", meta.supervisor,
      "Zweitgutachter:", meta.advisors,
    )
  )
  )
]

#pagebreak()

