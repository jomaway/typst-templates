#let default(authors, version: none) = [
    #sym.copyright 2023 
    #if (type(authors) == "array") [
    #authors.join(", ", last: " and ")
    ] else [
    #authors
    ]
    #box(
    height: 0.7em,
    image("../images/by-nc-sa.eu.svg")
    )
    #if version != none [
    \- v#version
    ]
    #h(1fr)
    #counter(page).display("1 / 1", both: true)
]