#import "components/footers.typ": default;
#import "components/helpers.typ": lines, quelle, mark;
#import "components/tasks.typ": *;
#import "components/boxes.typ": *;
#import "components/code-box.typ": *;

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
    footer: default(authors, version: version),
  )

// Update global state show solution
  show_lsg.update(lsg)

  set text(font: "Source Sans Pro", lang: "de")
  set par(leading: 0.75em)

  // Main body.
  
  set par(justify: true)
  set text(12pt)
  set heading(numbering: "1.")


  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  // Add small vertical space before each heading
  show heading.where(level: 2): it => {
    v(0.5em)
    it
  }
  // Content-Body
  body
}

#let title(title) = [
  #align(center)[
    #text(16pt, weight: 700, title)
  ]
]