= ReadMe
<appendix:readme>

#[
  #show raw: set text(size: 10pt)

  #let log-text = read("../Readme.md")

  #let wrapped-text = log-text.clusters().join(sym.zws)

  #raw(wrapped-text, lang: "md")
]
