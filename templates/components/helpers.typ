#let lines(count) = {
    for _ in range(count) {
        block(spacing: 1.6em, line(length:100%, stroke: rgb( 178, 186, 187 )) )
    }
}

// todo: check following 
#let mark(body) = {
  box(fill: rgb(255, 201, 75).lighten(20%), outset: (y:3pt), radius: 0.2em, body)
}

#let quelle(body, url: "", position: end) = {
  align(position)[
    #set text(size: 9pt)
    Quelle: #link(url)[#body]
  ]
}