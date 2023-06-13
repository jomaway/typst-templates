#import "components/tasks.typ": *

// The exam function defines how your document looks.
#let exam(
  kind: "exam", // shoes the kind of exam -> Schulaufgabe | Stegreifaufgabe | Kurzarbeit
  date: datetime.today(),     // date of the exam
  class: "",    
  subject: "" , 
  logo: "images/logo.png", // displays the logo of the school.
  authors: "JM", 
  intro: [Beantworten Sie alle Aufgaben mit *Kugelschreiber* und achten Sie auf ein *sauberes Schriftbild*!],  // used to display a hint about clean writing and if grammar is valued, etc...
  aids: none,   // display the allowed aids; default: none else takes a string. -> "TR" 
  grammar: false, // displays 
  lsg: false, 
  body
) = {
  
  // Set the document's basic properties.
  set document(author: authors, title: kind + "-" + class + subject)
  set page(
    margin: (left: 20mm, right: 20mm, top: 10mm, bottom: 20mm),
    footer: {
      sym.copyright; if type(date) == "datetime" { date.display("[year]") } else { datetime.today().display("[year]") }
      if (type(authors) == "array") [
      #authors.join(", ", last: " and ")
      ] else [
      #authors
      ]
      box(
        height: 0.7em,
        image("images/by-nc-sa.eu.svg")
      )
      h(1fr)
      text(10pt, weight: "semibold", font: "Atma")[
        Viel Erfolg #box(height: 1em, image("images/four-leaf-clover.svg"))
      ]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  )

  // Update global state show solution
  show_lsg.update(lsg)

  set text(font: "Source Sans Pro", lang: "de")
  set par(leading: 0.75em)

  // HEADER BLOCK
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
            #smallcaps("Datum: ") #if type(date) == "datetime" { date.display("[day].[month].[year]") } else {date}
            
          ],
          cell()[
            #align(center)[
              #block(below: 0.6em, 
                text(18pt, weight: 800, kind)
              )
              #if logo != none {image(logo, height: 12mm, fit: "contain")}
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
  // END HEADER BLOCK

  // Intro
  if intro != none {
    block(fill: rgb( 214, 234, 248 ), inset: 0.6em, width: 100%, radius: 0.3em)[
      #set text(11.5pt)
      #set par(leading: 1em)
      #intro \
      #if grammar [ *Rechtschreibung* wird bewertet. \ ] 
      *Hilfsmittel:* #if type(aids) == "none" [keine] else [#aids]
    ]
  }

  // Main body.

  // Text settings
  set text(12pt)
  set par(justify: true)
  
  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  show heading.where(level: 1): it => {
    set block(above: 1.2em, below: 1em)
    set text(12pt, weight: "semibold")
    task[#it.body]
  }
  
  show heading.where(level: 2): it => {
    set text(12pt, weight: "regular")
    question(points: none)[#it.body]
  }

  // Content-Body
  body

  // Footer 
  v(1fr)
  place(bottom + end)[
    #box(stroke: 1pt, inset: 0.8em)[
        #text(16pt, sym.sum) :  \_\_\_\_ \/ #total_points.display() #smallcaps("PT")
    ]
  ]
  
}

#let lines(count) = {
    for _ in range(count) {
        block(spacing: 1.6em, line(length:100%, stroke: rgb("#616A6B")) )
    }
}

