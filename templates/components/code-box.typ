// all credit goes to https://gitlab.com/LostPy/lostpy-typst-templates

#let this-counter = counter("code-box")

#let code-box(
  code, 
  explaination: none,
  label: none, 
  caption: none,
  inset: 12pt, 
  outset: (x: 0pt, y:0pt), 
  fill: luma(45), 
) = {
  let radius = 3pt

  show par: set block(below: 0em, above: 0em)
  set block( spacing: 0em)

  let _outset = (x: 0pt, y:0pt)

  if type(outset) == "dictionary" {
    for k in outset.keys() {
      _outset.insert(k, outset.at(k))
    }
  } else if type(outset) == "length" {
    _outset.x = outset
    _outset.y = outset
  }

  pad(
    y: _outset.y,
    [
      #pad(
        x: _outset.x,
        box(
          width: 100%,
          inset: 0pt,
          stroke: fill,
          radius: radius,
          [
              #block(
                width: 100%,
                radius: (top: radius),
                fill: fill,
                pad(
                  inset,
                  par(
                    justify: false,
                    text(
                      10pt,
                      hyphenate: false,
                      font: "DejaVu Sans Mono",
                      white, 
                      code
                    )
                  )
                )
              )
            #if explaination != none {
              line(length: 100%)
              pad(
                inset,
                explaination
              )
            } 
          ]
        )
      )
    
      #if caption != none {
        align(
          center,
          pad(
            12pt,
            [
              #if label != none {
                label
              }
              #this-counter.display():
              #caption
            ]
          )
        )
        this-counter.step()
      }
    ]
  ) 
}

#let codebox(code) = box(radius: 3pt, fill: luma(40), inset: 0.8em, text(font: "DejaVu Sans Mono", 10pt, white)[#code])


#show raw.where(block: true): code => {
    block(fill: luma(40), inset: 1em, radius: 3pt, width: 100%,
        text(
            hyphenate: false,
            font: "DejaVu Sans Mono",
            white, 
            code
        )
    )
}