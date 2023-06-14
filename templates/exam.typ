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
  print_cover: true,  // Adds an extra page at the bottom.
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

  if print_cover [
    // Cover page 
    #page(footer: none)[
      #show line: set line(stroke: luma(70))
      #set text(16pt, font:"New Computer Modern Sans" )

      // header
      #box(width: 100%, stroke: luma(70), inset: 1em, radius: 3pt)[
        #align(center)[#text(22pt)[Deckblatt Leistungsnachweis]]
        #place(top + right, dy: -15pt)[#image(logo, width: 2.5cm)]
      ]
      // content
      #grid(
        columns: (auto, 4.7cm, auto, auto),
        column-gutter: 1em,
        row-gutter: 1em,
        "Klasse: ", text(weight: "semibold", class),
        "Schuljahr: ", [ #if type(date) == "datetime" {
          if date.month() < 9 {str(date.year()-1) + "/" + str(date.year())} else { str(date.year()) + "/" + str(date.year()+1) }
        } else { align(bottom,line(length: 3cm))}
        ],
        "Fach: ", text(weight: "semibold", subject),
        "Art: ", kind,
      )
      #v(0.5cm)
      
      // Missing student and student count
      #table(
        columns: (auto),
        row-gutter: (1cm),
        stroke: none,
        inset: 0pt,
        align: bottom,
        [Fehlende SchülerInnen: #box(width: 1fr)[#align(end)[Schülerzahl: #h(2cm)]]],
        line(length: 100%),
        line(length: 100%),
      )
      // Dates
      Datum: #h(1fr)
      #box(stroke: (bottom: 1pt), width: 3.5cm, inset: (bottom: 3pt))[
        #align(center)[
          #if type(date) == "datetime" { 
            date.display("[day].[month].[year]") 
          } else {date}
        ]
        #place(end,dy: 7pt)[#text(10pt, "gehalten")]
      ] #h(1fr) 
      #box(stroke: (bottom: 1pt), width: 3.5cm)[
        #place(end,dy: 4pt)[#text(10pt, "zurückgegeben")]
      ] #h(1fr) 
      #box(stroke: (bottom: 1pt), width: 3.5cm)[
        #place(end,dy: 4pt)[#text(10pt, "Noten eingetragen")]
      ]
      #v(0.5cm)

      // Grading table uses the ihk grading distribution
      #locate(loc => {
        let max_points = total_points.final(loc);
        let dist = range(max_points * 10, step: 5).map(el => {
          let points = el*0.1;
          let percent = calc.round(points/max_points, digits:2);
          let grade = if percent < 0.3 {6} else if percent < 0.5 {5} else if percent < 0.67 {4} else if percent < 0.81 {3} else if percent < 0.92 {2} else {1}
          return (points, grade)
        })
        dist.push((max_points, 1));

        // Using a second table in a block for colspan effect
        block[
          #show table: set block(below: 0pt)
          #table(
            columns: (2cm, 1fr, 5cm),
            inset: 0.7em,
            align: center,
            "Note", "Punkteschlüssel", "Anzahl",
            ..range(6).map(el => ([#{el + 1}],align(start)[#h(2cm,)
              von #box(width: 2.2em, inset: (left: 4pt))[#dist.find(val => val.at(1) ==  el+1).at(0)]
              bis #box(width: 2.2em, inset: (left: 4pt))[#dist.rev().find(val => val.at(1) == el+1).at(0)]
            ], "")).flatten(),
          )
          #table(
            columns: (1fr, 5cm),
            inset: 0.7em,
            [#align(end)[Notendurchschnitt #text(22pt,sym.diameter):]], "",
          )
        ]
      })

      // Comment
      #table(
        columns: (auto),
        row-gutter: 1cm,
        stroke: none,
        inset: 0pt,
        align: bottom,
        smallcaps("Bemerkung:"), 
        line(length: 100%),
        line(length: 100%),
      )
      
      // Unterschrift
      #align(bottom, 
        box(
          stroke: (top: (thickness:1pt, paint:blue, dash: "dashed") ), 
          width: 100%, 
          inset: (top: 4pt)
        )[
          #text(12pt)[#smallcaps("Unterschrift:")]
          
          #h(1cm)
          #box(stroke: (bottom: 0.5pt), width: 6cm, height: 1cm)[
            #place(end,dy: 4pt)[#text(10pt, "Lehrer")]
          ] #h(1fr)
          #box(stroke: (bottom: 0.5pt), width: 6cm, height: 1cm)[
            #place(end,dy: 4pt)[#text(10pt, " Fachbetreuer")]
          ]
        ]
      )      
      // fix page count
      #counter(page).update(0)
    ] // end page
  ] // end if print_cover
  
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