#import "@preview/touying:0.5.5": *
#import "theme.typ": *

#show: university-theme.with(
  config-colors(
    primary: rgb("#13496d"),
    secondary: rgb("#00708f"),
    tertiary: rgb("#00989d"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#000000"),
  ),
  config-info(
    title: [],
    subtitle: [],
    author: [],
    date: [],
    institution: [],
  ),
  aspect-ratio: "16-9"
)


#set heading(numbering: "1.1 ")
#show figure.caption: set text(15pt)


== Bibliography
#bibliography("references.bib")

#focus-slide[#align(center)[Thank you! \ \ #text(size: 30pt, "Questions?")]]