// Global state 
#let show_lsg = state("s", false)
#let total_points = state("t", 0)

#let tc = counter("task-counter");

/*
  function for the numbering of the tasks and questions
*/
#let tasknumbering = (..args) => {
    let nums = args.pos()
    if nums.len() == 1 {
      numbering("1. ", nums.last())
    } else if nums.len() == 2 {
      numbering("a) ", nums.last())
    }
  }

/*
  draws a small gray box which indicates the amount of points for that task/question
  
  points: given points -> needs to be an integer
  plural: if true it displays an s if more than one point
*/
#let pointbox(points, plural: false) = {
  assert.eq(type(points),"integer")
  total_points.update(t => t + points)
  box(
      inset: 4pt,
      radius: 0.2em,
      fill : gray.lighten(35%),
      height: 1.1em
    )[
        #set align(center + horizon)
        #set text(12pt, weight: "regular")
        #points #smallcaps[pt#if points > 1 and plural [s]]
    ]
}

/*
  template for a grid to display the pointbox on the right side.
*/
#let pointgrid(body, points) = {
  grid(
    columns: (1fr, auto),
    gutter: 1.5em,
    body,
    if points != none {
      pointbox(points)
    }
  )
}

/*
  task indicates a new section of questions.
  It updates the task-counter on the first level.
  It displays the title of the new task and numbers it with digits.
  optional a point box can be displayed for a whole task.
  Example:

  1. Aufgabe 
  2. Aufgabe
  ...
*/
#let task(title, points: none) = {
  set text(12pt, weight: 600)
  pointgrid({
      tc.step()
      tc.display(tasknumbering); title
    },
    points
  )
}
/*
  question indicates a new questions.
  It updates the task-counter on the second level.
  It numberes the question with letters.
  optional the level can be stated as 1 
  
  Example:
  a) Describe what you have learned so far         [2PT]
  b) Give an example of a question with 1 point    [1PT]
*/
#let question(body, points: none, level: 2) = [
  #set text(12pt, weight: "regular")
  #pointgrid({
      tc.step(level: level)
      tc.display(tasknumbering)
      body
    },
    points
  )
]

/*
  solution for a question
  will only be printed if the global state show_lsg is true.
  You can achieve this by calling show_lsg.update(true) from your document.
  Optional you can give a placeholder which will be printed if show_lsg is false.
*/
#let solution(solution, placeholder: []) = {
    locate(loc => {
      if show_lsg.at(loc) == false { placeholder }
    })
    set text(fill: rgb( 255, 87, 51 ))
    locate(loc => {
      if show_lsg.at(loc) == true { solution }
    })
}

/*
  body will only be printed if show_lsg is false
*/
#let notifso(body) = {
  locate(loc => {
    if show_lsg.at(loc) == false { body }
  })
}

#let mct(choices: (), answer: none) = [
  #assert(type(answer) == "integer", message: "Answer needs to be an integer of the correct answer")
  #assert(type(choices) == "array", message: "Choises must be given as an array")
  #assert(choices.len() >= answer, message: "anwers outside of bound")
  
  #for (i,a) in choices.enumerate() [
      #box(inset: (x: 0.5em))[
        #locate(loc => {
         square(
          width: 0.8em, 
          height: 0.8em, 
          stroke: black, 
          fill: if show_lsg.at(loc) and (i+1)==answer {red})
          
        })
      ] #a \
  ]
]