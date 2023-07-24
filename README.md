# Polylux
This is a package for creating presentation slides in [Typst](https://typst.app/).

[![Book badge](https://img.shields.io/badge/docs-book-green)](https://andreaskroepelin.github.io/polylux/book)
![GitHub](https://img.shields.io/github/license/andreasKroepelin/polylux)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/andreasKroepelin/polylux)
[![Demo badge](https://img.shields.io/badge/demo-pdf-blue)](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)

## Quickstart
For the bare-bones, do-it-yourself experience, all you need is:
```typ
// Get polylux from the official package repository
#import "@preview/polylux:0.2.0": *

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
#set text(size: 25pt)

// Use #polylux-slide to create a slide and style it using your favourite Typst functions
#polylux-slide[
  #align(horizon + center)[
    = Very minimalist slides

    A lazy author

    July 23, 2023
  ]
]

#polylux-slide[
  == First slide

  Some static text on this slide.
]

#polylux-slide[
  == This slide changes!

  You can always see this.
  // Make use of features like #uncover, #only, and others to create dynamic content
  #uncover(2)[But this appears later!]
]
```
This code produces these PDF pages:
![minimalist example](assets/minimalist.png)

From there, you can either start creatively adapting the looks to your likings
or you can use one of the provided themes.
The simplest one of them is called `simple` (what a coincidence!).
It is still very unintrusive but gives you some sensible defaults:
```typ
#import "@preview/polylux:0.2.0": *

#import themes.simple: *

#show: simple-theme.with(
  footer: [Simple slides],
)

#title-slide[
  = Keep it simple!
  #v(2em)

  Alpha #footnote[Uni Augsburg] #h(1em)
  Bravo #footnote[Uni Bayreuth] #h(1em)
  Charlie #footnote[Uni Chemnitz] #h(1em)

  July 23
]

#slide[
  #outline()
]

#slide[
  == First slide

  #lorem(20)
]

#focus-slide[
  _Focus!_

  This is very important.
]

#centered-slide[
  = Next part
]

#slide[
  == Let's see some sources
  Where have they gone?

  #uncover(2)[
    Ahh here they are:
    @A @B @C @D @E @F @G @H
  ]
]

#centered-slide[
  = Appendix

  ... what no one wants to see.
]


#slide[
  == Bibliography
  #bibliography(title: none, "literature.bib")
]
```
As you can see, a theme can introduce its own types of slides (here: `title-slide`,
`slide`, `focus-slide`, `centered-slide`) to let you quickly switch between
different layouts.
The book (**TODO**) has more infos on how to use (and create your own) themes.


For dynamic content, polylux also provides [a convenient API for complex
overlays](https://andreaskroepelin.github.io/polylux/book/dynamic.html).

Visit the
[book](https://andreaskroepelin.github.io/polylux/book)
for more details or take a look at the
[demo PDF](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)
where you can see the features of this template in action.

**⚠ This package is in active development.
While I try to make sure that the `main`-branch always is in a usable state,
there are no compatibility guarantees!**

## Acknowledgements
Thank you to...
- [@drupol](https://github.com/drupol) for the `university` theme
- [@Enivex](https://github.com/Enivex) for the `metropolis` theme
- [@MarkBlyth](https://github.com/MarkBlyth) for the `bristol` theme
- [@fncnt](https://github.com/fncnt) for coming up with the name "polylux"
- the Typst authors and contributors for this refreshing piece of software
