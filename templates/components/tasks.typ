// Global state 
#let show_lsg = state("s", false)
#let total_points = state("t", 0)

#let tc = counter("task-counter");
#let qc = counter("question-counter");
#let reset_qcount() = { qc.update(0)}

#let task = [
  #tc.step();
  #qc.display("1.") Aufgabe
  #reset_qcount()
]

#let task(body) = {
  set text(weight: 600)
  tc.step()
  tc.display("1.")
  " Aufgabe"
  qc.update(0)
  linebreak()
  set text(weight: "regular")
  body
}

#let question(body, points: none) = [ 
  #total_points.update(t => t + points)
  #grid(
    columns: (1fr, auto),
    gutter: 1.5em,
    [ 
      #qc.step()
      #qc.display("a)")
      #body
    ],
    if points != none {
      box(
        inset: 4pt,
        radius: 0.2em,
        fill : gray.lighten(35%),
        height: 1.1em
      )[
          #set align(center + horizon)
          #points #smallcaps("pt") //pt#{if points>1 {[s]}}
      ] 
    }
  )
]

#let solution(body) = {
    set text(fill: rgb( 255, 87, 51 ))
    locate(loc => {
      if show_lsg.at(loc) == true { body }
    })
}