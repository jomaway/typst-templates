// all credits to: https://github.com/lvignoli/diapo

#let scriptsize = 8pt

#let transition(
	// The slide accent color. Default is a vibrant yellow.
	accent-color: rgb("f3bc54"),

	// The slide content.
	body,
) = {
	page(
		width: 15cm,
		height: 10cm,
		background: rect(width: 100%, height: 100%, fill: accent-color),
		header: none,
		footer: none,
	)[
		#set align(center+horizon)
		#set text(28pt, fill: white, weight: "bold")
		#body
	]
}

#let diapo(
	// The presentation's title, which is displayed on the title slide.
	title: [Title],

	// The presentation's author, which is displayed on the title slide.
	author: none,

	// The date, displayed on the title slide.
	date: none,

	// If true, display the total number of slide of the presentation.
	display-lastpage: true,

	// If set, this will be displayed on top of each slide.
	short-title: none,

    // If set will display above the title
    img: none,

	// The presentation's content.
	body
) = {
	// Set the metadata.
	set document(title: title, author: author)

	// Configure page and text properties.
	set text(font: "Source Sans Pro", weight: "regular")
	set page(
		width: 15cm,
		height: 10cm,
		header: if short-title != none {
			set align(right)
			set text(size: scriptsize)
			short-title
		},
		footer: [
			#let lastpage-number = locate(pos => counter(page).final(pos).at(0))
			#set align(right)
			#text(size: scriptsize)[
				*#counter(page).display("1")* 
				#if (display-lastpage) [\/ #lastpage-number]
			]
		],
	)

	// Display the title page.
	page(background: none, header: none, footer: none)[
		#set align(center+horizon)

        #if img != none {
            image(img, height: 3cm)       
        }

		#set text(24pt, weight: "light")
		#title

        #if author != none {
		    text(14pt)[
                by #author
            ]
        }
        
        #if date != none {
            text(features: ("case",), date)
        }

	]

    // Increase base font size to 14pt
    set text(14pt)

	// Customize headings to show new slides.
	show heading: set text(font: "Poppins")
	show heading.where(level: 1): it => {
		pagebreak()
		align(top, it)
		v(0.6em)
	}

	// Add the body.
	body
}