// colors
#let colors = (
  bg: rgb(16, 19, 24),
  section: rgb(25, 28, 33),
  block: rgb(36, 37, 42),
  text: luma(240),
  accent: rgb(27, 172, 217),
)

#let cc-by-sa-nc = text(font:"CCSymbols")[\u{1F16D} \u{1F16F} \u{1F10E} \u{1F10F}] 

#let cheatsheet(
  title: "Cheatsheet",
  subtitle: "Another wonderfull one",
  author: "JM",
  body
) = {
    set document(author: author, title: title + "-" + subtitle)
  set page(
    margin: 0pt,
    background: box(width: 100%, height: 100%, fill: colors.at("bg")),
    footer: [
      #set text(fill: colors.at("accent"))
      #place(bottom + left)[
        #box(inset: 0.5em)[
          #sym.copyright;  #datetime.today().display("[year]") #author -   #cc-by-sa-nc
        ]
      ]
    ],
  )
  set text(fill: luma(240))

  box(width: 100%, height: 5cm)[
    #place(top, image("images/vital-ocien.svg",width: 100%))
    #set align(center + horizon)
    #stack(dir: ttb, spacing: 1em,
      text(4em, weight: "bold",)[#smallcaps(title)],
      text(2em, weight: "bold",)[#subtitle],
    )
  ]

  show raw.where(block: true): code => {
    box(fill: rgb(36, 37, 42), radius: 5pt, inset:1em, code)
  }

  pad(x:1cm, y: 1em)[#body]

}

#let section(content) = {
  box(fill: rgb(25, 28, 33), radius: 5pt, width: 100%, inset: 1em)[
    #content
  ]
}