#let normal_table(columns: auto, ..cells) = {
    set table(
      fill: (x, y) => if y == 0 { rgb("BDC1D0") },
    )
    set align(left)
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
    table(columns:columns,..cells)
}

#let striped_table(columns:auto, ..cells) = {
    set table(
      fill: (x, y) => if calc.odd(y) { rgb("BDC1D0") } else {white},
      inset: (right: 1.5em),
    )

    show table.cell: it => {
      if calc.rem(it.y,2)  {
        set text(black)
        strong(it)
      } else if it.body == [] {
        pad(..it.inset)[_N/A_]
      } else {
        it
      }
    }
    table(columns:columns,..cells)
}

#let cover_table(columns:auto, ..cells) ={
    set table(
      fill: white,
      // inset: (right: 1.5em),
      stroke:none,
    )
    show table: set text(weight:"regular", size:12pt)
    show table: set align(left)

    show table.cell: it => {
      it
    }
    show table.header: set text(weight: "regular")

    table(columns:columns,..cells)

    
}
#let tbl = (
  normal: normal_table,
  striped: striped_table,
  cover: cover_table,
)

#let fmt_table(kind: tbl.normal, caption:none, outlined:true,  columns: auto, ..cells)={
  figure(
    outlined:outlined,
    caption:caption,
    kind: table,
    kind(columns: columns, ..cells)
  )
}
