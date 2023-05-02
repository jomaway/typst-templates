// all credits to: https://github.com/lkoehl/typst-boxes

#let colorbox(title: "title", color: none, radius: 2pt, width: auto, body) = {

  let strokeColor = luma(70)
  let backgroundColor = white

  if color == "red" {
    strokeColor = rgb(237, 32, 84)
    backgroundColor = rgb(253, 228, 224)
  } else if color == "green" {
    strokeColor = rgb(102, 174, 62)
    backgroundColor = rgb(235, 244, 222)
  } else if color == "blue" {
    strokeColor = rgb(29, 144, 208)
    backgroundColor = rgb(232, 246, 253)
  } else if color == "yellow" {
    strokeColor = rgb(255, 201, 23)
    backgroundColor = rgb( 252, 243, 207  )
  }

  return box(
    fill: backgroundColor,
    stroke: 2pt + strokeColor,
    radius: radius,
    width: width,
  )[
    #box(
      fill: strokeColor, 
      inset: 6pt,
      radius: (top-left: radius, bottom-right: radius),
    )[
      #text(fill: white, weight: "bold")[#title]
    ] 
    #box(
      width: 100%,
      inset: (x: 8pt, bottom: 8pt)
    )[
      #body
    ]
  ]
}

#let slantedBackground(color: black, body) = {
  set text(fill: white, weight: "bold")
  style(styles => {
    let size = measure(body, styles)
    let inset = 8pt
    [#block()[
      #polygon(
        fill: color,
        (0pt, 0pt),
        (0pt, size.height + (2*inset)),
        (size.width + (2*inset), size.height + (2*inset)),
        (size.width + (2*inset) + 6pt, 0cm)
      )
      #place(center + top, dy: size.height, dx: -3pt)[#body]
    ]]
  })
}

#let slantedColorbox(title: "title", color: none, radius: 0pt, width: auto, body) = {

  let strokeColor = luma(70)
  let backgroundColor = white

  if color == "red" {
    strokeColor = rgb(237, 32, 84)
    backgroundColor = rgb(253, 228, 224)
  } else if color == "green" {
    strokeColor = rgb(102, 174, 62)
    backgroundColor = rgb(235, 244, 222)
  } else if color == "blue" {
    strokeColor = rgb(29, 144, 208)
    backgroundColor = rgb(232, 246, 253)
  }

  return box(
    fill: backgroundColor,
    stroke: 2pt + strokeColor,
    radius: radius,
    width: width
  )[
    #slantedBackground(color: strokeColor)[#title]
    #box(
      width: 100%,
      inset: (top: -2pt, x: 10pt, bottom: 10pt)
    )[
      #body
    ]
  ]
}

#let outlinebox(title: "title",color: none, width: 100%, radius: 2pt, centering: false, body) = {

  let strokeColor = luma(70)

  if color == "red" {
    strokeColor = rgb(237, 32, 84)
  } else if color == "green" {
    strokeColor = rgb(102, 174, 62)
  } else if color == "blue" {
    strokeColor = rgb(29, 144, 208)
  } else if color == "yellow" {
    strokeColor = rgb(255, 201, 23)
  }
  
  return block(
      stroke: 2pt + strokeColor,
      radius: radius,
      width: width,
      above: 26pt,
    )[
      #if centering [
        #place(top + center, dy: -12pt)[
          #box(
            fill: strokeColor,
            inset: 8pt,
            radius: radius,
          )[
            #text(fill: white, weight: "bold")[#title]
          ]
        ]
      ] else [
        #place(top + start, dy: -12pt, dx:20pt)[
          #box(
            fill: strokeColor,
            inset: 8pt,
            radius: radius,
          )[
            #text(fill: white, weight: "bold")[#title]
          ]
        ]
      ]
      
      #box(
        width: 100%,
        inset: (top:20pt, x: 10pt, bottom: 10pt)
      )[
        #body
      ]
    ]
}

#let stickybox(rotation: 0deg, width: 100%, body) = {
  let stickyYellow = rgb(255, 201, 75)
  
  return rotate(rotation)[
    #box(
      fill: stickyYellow,
      width: width,
      radius: 2pt,
    )[
      #place(top + center, dy: -10pt)[
        #rotate(-1.2deg)[
          #box(
            fill: rgb(0,0,0).lighten(75%), 
            width: 1.5in,
            height: 20pt,
          )
        ]
      ]
      #box(
        width: 100%,
        inset: (top:18pt, x: 8pt, bottom: 8pt)
      )[
        #body
      ]
    ]
  ]
}


#let taskbox(title: "Aufgabe", body) = {
  slantedColorbox(title: title, color: "blue", body)
}

#let merke(title: "Merke", body) = {
  colorbox(title:title, color: "red", body)
}

#let infobox(title: "Info", body) = {
  colorbox(title:title, color: "green", body)
}

#let headlessbox(color: none, radius: 2pt, width: auto, body) = {
  let strokeColor = luma(70)
  let backgroundColor = white

  if color == "red" {
    strokeColor = rgb(237, 32, 84)
    backgroundColor = rgb(253, 228, 224)
  } else if color == "green" {
    strokeColor = rgb(102, 174, 62)
    backgroundColor = rgb(235, 244, 222)
  } else if color == "blue" {
    strokeColor = rgb(29, 144, 208)
    backgroundColor = rgb(232, 246, 253)
  } else if color == "yellow" {
    strokeColor = rgb(255, 201, 23)
    backgroundColor = rgb( 252, 243, 207  )
  }

  return box(
    fill: backgroundColor,
    stroke: 2pt + strokeColor,
    radius: radius,
    width: width,
    inset: 8pt,
    body
  )
}

#let infobox(body) = {
  headlessbox(color: "green", body)
}