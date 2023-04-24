// all credit goes to https://gitlab.com/LostPy/lostpy-typst-templates

#let this-counter = counter("code-box")

#let code-box(
  code, 
  explaination: none,
  label: none, 
  caption: none,
  inset: 16pt, 
  outset: 0pt, 
  fill: luma(45), 
) = {

  let radius = 3pt
  set block(spacing: 0pt)
  
  pad(
    y: inset,
    [
      #pad(
        x: outset,
        rect(
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
                      hyphenate: false,
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
