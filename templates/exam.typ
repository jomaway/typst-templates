#import "components/footers.typ": default;
#import "components/helpers.typ": lines;
#import "components/tasks.typ": *;


// The exam function defines how your document looks.
#let exam(kind: "exam", date: "", class: "", subject: "" , logo: "images/logo.png", authors: ("JM"), intro: true, aids: none, grammar: false, lsg: false, body) = {
  
  // Set the document's basic properties.
  set document(author: authors, title: kind + "-" + class + subject)
  set page(
    margin: (left: 20mm, right: 20mm, top: 10mm, bottom: 20mm),
    footer: default(authors)
  )

  // Update global state show solution
  show_lsg.update(lsg)

  set text(font: "Source Sans Pro", lang: "de")
  set par(leading: 0.75em)

  // Heading block
  let cell(content) = {
    set align(left)
    rect(
      width: 100%,
      height: 100%,
      inset: 0.7em,
      stroke: 1pt, //(left: 1pt, right: 1pt),
      [
        #set text(13pt)
        #set align(top + left)
        #content
      ]
    )
  }

  [
    #rect(
      inset: 0mm, 
      outset: 0mm, 
      stroke: (bottom: 1pt, top: 1pt),
      grid(
        columns: (auto),
        rows: (35mm),
        grid(
          columns: (1fr, 35mm),
          rows: (25mm),
        grid(
          columns: (1fr, 2fr),
          cell()[
            #set text(13pt)
            #set align(horizon)
            #set par(leading: 1em)
            #smallcaps("Klasse: ") #class \ 
            #smallcaps("Fach: ") #subject \
            #smallcaps("Datum: ") #date 
            
          ],
          cell()[
            #align(center)[
              = #kind
              #image(logo, height: 12mm, fit: "contain")
            ]
          ],
        ),
        grid(
          rows: 35mm,
          cell()[
            #align(top + start)[
            #smallcaps("Note:")]
          ],  
        ),
          grid(
          columns: 100%,
          rows: 10mm,
          cell()[#smallcaps("Name:")]
        )
      )
    )
    )
  ]
  // END Heading

  // Intro
  if intro == true {
    block(fill: rgb( 214, 234, 248 ), inset: 0.6em, width: 100%, radius: 0.3em)[
      #set text(11.5pt)
      #set par(leading: 1em)
      Beantworten Sie alle Aufgaben mit *Kugelschreiber* und achten Sie auf ein *sauberes Schriftbild*! \
      #if grammar [ *Rechtschreibung* wird bewertet. \ ] 
      *Hilfsmittel:* #if type(aids) == "none" [keine] else [#aids]
    ]
  }


  // Main body.
  
  set par(justify: true)
  set text(12pt)
  show heading: set text(12pt, weight: 600)

  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  // Content-Body
  body
}


#let goodluck = {
  align(center)[
    Viel Erfolg #box(height: 1em, image("images/four-leaf-clover.svg"))
  ]
}
