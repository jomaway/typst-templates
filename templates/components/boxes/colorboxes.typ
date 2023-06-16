/*
  Colorboxes are a set of predefined colorfull boxes. Easy to extend and modify
  
  author: jomaway
  version: 0.2

  = Version 0.2
  - Added titledbox
  - Added stickybox (beta)

  = Version 0.1
  - Added colorbox
  - Added iconbox
  - Added admonitions (definition, info, memo, todo, quest, concl)
*/

// color profiles
#let colors = (
  gray:   (border: luma(70),          bg: luma(230)),
  blue:   (border: rgb(29, 144, 208), bg: rgb(232, 246, 253)),
  green:  (border: rgb(102, 174, 62), bg: rgb(235, 244, 222)),
  red:    (border: rgb(237, 32, 84),  bg: rgb(253, 228, 224)),
  yellow: (border: rgb(255, 201, 23), bg: rgb(252, 243, 207)),
  purple: (border: rgb(158, 84, 159), bg: rgb(241, 230, 241))
)

#let frame(body, strokecolor: luma(70)) = {
  layout(size => style(styles => {
    let (height,) = measure(body,styles)
    // top left vorner
    place(
      top + left,
      path(
        fill: strokecolor,
        stroke: (paint: strokecolor, thickness: 1pt, cap: "round", join: "round" ),
        closed: true,
        (1pt, 0pt),              // offset for rounded corner
        (0.3pt, 0.3pt),          // corner point
        (0pt, 1pt),              // offset for rounded corner
        (0pt, height * 0.4),     // vertical line
        (1.5pt, 1.5pt),          // inset corner point
        (size.width * 0.3, 0pt), // horizontal line
      )
    )
    // content body
    body
    // bottom right corner
    place(
      right,
      path(
        fill: strokecolor,
        stroke: (paint: strokecolor, thickness: 1pt, cap: "round", join: "round" ),
        closed: true,
        (-1pt, 0pt),
        (-0.3pt, -0.3pt),
        (0pt, -1pt),  
        (0pt, -height * 0.4),
        (-1.5pt, -1.5pt),
        (-size.width * 0.3, 0pt),
      )
    ) 
  }))  // END styles/ layout
}

/*
  Basic colorbox with a cornerd border frame

  color: select a color duo -> gray | blue | green | red | yellow | purple 
*/
#let colorbox(body, color: "gray", width: auto, border: auto, radius: 3pt, inset: 1em) = {
  // Set default border
  border = if border == auto {"cornered"} else { border } // posible borders solid, none, cornered
  
  // setting bg and stroke color from parameter
  let strokecolor = colors.at(color).border
  let bgcolor = colors.at(color).bg;

  // Disable Heading numbering for those headings
  set heading(numbering: none, outlined: false, supplement: "Box")

  box(
    width: width,
    fill: bgcolor,
    radius: radius,
    stroke: if border == "solid" {2pt + strokecolor},
  )[
    #let innerwidth = if type(width) == "ratio" { 100% } else { width }
    #block(width: innerwidth)[
      #let content = box(inset: inset, body)

      #if border == "cornered" [
        #frame(strokecolor: strokecolor)[#content]
      ] else [
        #content
      ]
    ] 
  ]
} 

/*
  ICONBOX
*/
#let iconbox(body, icon: emoji.megaphone, iconsize: 3em, ..args) = {
  colorbox(..args)[
    #grid(
      columns: (auto, auto),
      gutter: 1em,
      box(height: iconsize)[
        #if type(icon) == "symbol" {
           text(iconsize,icon)
        } else {
          image(icon, fit: "contain")
        }
      ],
      body
    )

  ]
}

/* 
  TITLED BOX - !!! NEW !!!
*/
#let titledbox(title: "", body, border: none, radius: 3pt, inset: 1em, color: "gray", ..args) = {
  let strokecolor = colors.at(color).border
  let titleinset = 6pt
  colorbox(border: border, inset: 0pt, color: color, ..args)[
    #layout(size => style(styles => {
        // calculations
        let content = block(inset: inset, above: 0pt, clip: false)[#body]
        let contentsize = measure(content, styles)  //measure size of content
        let titletext = text(1.1em, fill: if color != "yellow" { white } else { black }, weight: "bold", title)
        let titlesize = measure(box(titletext, inset: titleinset), styles)
        let boxwidth = if args.named().keys().contains("width") and args.named().at("width") != auto { 
          100% 
        } else { 
          calc.min(
            size.width, // parent width
            calc.max(contentsize.width, titlesize.width )
          ) 
        }
      
        // title
        box(fill: strokecolor, inset: titleinset, radius: (top-left: radius, top-right: radius), width: boxwidth)[
          #titletext
        ]
        // body
        content
    }))
  ]
}

/*
  DEFINITION
*/
#let definition(content, title: "Definition", src: none, stretch: false, border: "solid") = {
  colorbox(color:"blue", width: if stretch {100%} else {auto}, border: border)[
    #align(start)[
      = #title
      #content
    ]
    #if src != none {
      align(end)[
        #set text(0.85em)
        Quelle: #link(src)
      ]
    }
  ]
}

/*
  admonition abstracts some logic which is used for the following predefined boxes
*/
#let admonition(body, title: none, stretch: true, ..args) = {
  iconbox(width: if stretch {100%} else {auto}, ..args)[
    #if title != none [#text(1.2em, weight: "bold",smallcaps[#title])]
    #align(horizon, body)
  ] 
}

/*
  INFO
*/
#let info(body, title: none, ..args) = {
  admonition(color:"green", icon: "info_green.svg", iconsize: 2em, title:title, ..args)[#body]
}

/*
  MEMORIZE | MEMO
*/
#let memo(body, title: "Merke", ..args) = {
  admonition(color:"red", icon: "excl.svg", title:title, ..args)[#set text(14pt); #body]
}

/*
  CONCLUSION
*/
#let concl(body, title: "Zusammenfassung", ..args) = {
  admonition(color: "yellow", icon: "lightbulb.svg", title:title, ..args)[#body]
}


/*
  QUESTION
*/
#let quest(body, title: none, ..args) = {
  admonition(color: "purple", icon: "quest.svg", title:title, ..args)[#set text(14pt);#body]
}

/*
  TODO
*/
#let todo(body, title: "Aufgabe", ..args) = {
  admonition(color: "purple", icon: "task.svg", title:title, ..args)[
    #set list(marker: box(width: 0.8em, height: 0.8em, stroke: black))
    #set text(14pt)
    #body
  ]
}


/*
  QR CODE BOX
*/
#let qrbox(path, size: 5em, scanme: true, ..args) = {
  colorbox(inset:size*0.1, ..args)[
    #set block(spacing: 0.5em)
    #box(height: size,image("qr_colorboxes.png")) 
    #if scanme [\ #align(center,smallcaps(text(size/5, weight: "semibold","scan me")))]
  ]
}





/*
  !!! WIP !!! - STICKY NOTE
  credits to: https://github.com/lkoehl/typst-boxes for the idea
*/
#let stickybox(rotation: 0deg, body) = {
  let stickyYellow = rgb(243, 223, 109)
  style(styles => {
    let content = block(inset: (top:20pt, x: 10pt, bottom: 12pt))[#align(start)[#body]]
    let size = measure(content, styles)
 
  rotate(rotation)[
    #box(
      fill: stickyYellow,
      width: size.width,
      height: size.height,
      radius: 2pt,
    )[
      
      #place(top + center, dy: -10pt)[
        #rotate(-1.2deg)[
          #box(
            fill: luma(200), 
            width: 60%,
            height: 20pt,
          )
        ]
      ]
      #content
    ]
  ]
  })
}