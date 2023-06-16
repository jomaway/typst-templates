#import "components/helpers.typ": lines, quelle, mark;
#import "components/boxes/colorboxes.typ": *;
#import "components/boxes/code-box.typ": *;
#import "components/tasks.typ": * 

#let worksheet(topic: "", subject: "",  authors: ("JM"), version: "1.0", lsg: false, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: topic)
  set page(
    margin: (left: 20mm, right: 20mm, top: 15mm, bottom: 20mm),
    header: [
        #box(height: 15mm, inset: 1mm)[
            #grid( columns: (1fr, 1fr), rows: 100%,  
                subject
            ,
                align(bottom + end)[
                #set text(13pt) 
                #smallcaps(topic)]
            )
        ]
        #place(bottom, line(length: 100%) )
    ],
    header-ascent: 5mm,
    footer: {
      sym.copyright; datetime.today().display("[year]")
      if (type(authors) == "array") [
      #authors.join(", ", last: " and ")
      ] else [
      #authors
      ]
      box(
        height: 0.7em,
        image("images/by-nc-sa.eu.svg")
      )
      if version != none [
      \- v#version
      ]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    },
  )

// Update global state show solution
  show_lsg.update(lsg)

  //set text(font: "Source Sans Pro", lang: "de")
  set text(font: "Corbel", lang: "de")
  // Set spacing between lines
  set par(leading: 0.75em)

  // Main body.
  
  set par(justify: true)
  set text(12pt)

  // Set paragraph spacing.
  //show par: set block(above: 1.2em, below: 1.2em)

  // Only set numbering on the first and second level.
  set heading(numbering: (..args) => {
  let nums = args.pos()
  if nums.len() >= 3 {
    []
  } else {
    numbering("1.", ..nums)
  }
})


  // Content-Body
  body
}

#let title(title) = [
  #align(center)[
    #text(16pt, weight: 700, title)
  ]
]

