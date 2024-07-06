# Polylux <img src="https://andreaskroepelin.github.io/polylux/book/logo.png" style="width: 3em;"></img>
This is a package for creating presentation slides in [Typst](https://typst.app/).
Read the [book](https://polylux.dev/book) to learn all
about it and click [here](https://polylux.dev/book/changelog.html)
to see what's new!

If you like it, consider [giving a star on GitHub](https://github.com/andreasKroepelin/polylux)!

[![Book badge](https://img.shields.io/badge/docs-book-green)](https://polylux.dev/book)
![GitHub](https://img.shields.io/github/license/andreasKroepelin/polylux)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/andreasKroepelin/polylux)
![GitHub Repo stars](https://img.shields.io/github/stars/andreasKroepelin/polylux)
[![Demo badge](https://img.shields.io/badge/demo-pdf-blue)](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)
![Themes badge](https://img.shields.io/badge/themes-5-aqua)


## Quickstart
For the bare-bones, do-it-yourself experience, all you need is:
```typ
// Get Polylux from the official package repository
#import "@preview/polylux:0.3.1": *

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
![minimal example](https://polylux.dev/book/minimal.png)

From there, you can either start creatively adapting the looks to your likings
or you can use one of the provided themes.
The simplest one of them is called `simple` (what a coincidence!).
It is still very unintrusive but gives you some sensible defaults:
```typ
#import "@preview/polylux:0.3.1": *

#import themes.simple: *

#set text(font: "Inria Sans")

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
  == First slide

  #lorem(20)
]

#focus-slide[
  _Focus!_

  This is very important.
]

#centered-slide[
  = Let's start a new section!
]

#slide[
  == Dynamic slide
  Did you know that...

  #pause
  ...you can see the current section at the top of the slide?
]
```
This time, we obtain these PDF pages:
![simple example](https://polylux.dev/book/themes/gallery/simple.png)

As you can see, a theme can introduce its own types of slides (here: `title-slide`,
`slide`, `focus-slide`, `centered-slide`) to let you quickly switch between
different layouts.
The book
[has more infos](https://polylux.dev/book/themes/themes.html)
on how to use (and create your own) themes.


For dynamic content, Polylux also provides [a convenient API for complex
overlays](https://polylux.dev/book/dynamic/dynamic.html).

If you use [pdfpc](https://pdfpc.github.io/) to display your slides, you can rely
on [Polylux' support for it](https://polylux.dev/book/external/pdfpc.html)
and create speaker notes, hide slides, configure the timer and more!

Visit the
[book](https://polylux.dev/book)
for more details or take a look at the
[demo PDF](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)
where you can see the features of this template in action.

**⚠ This package is under active development and there are no backwards
compatibility guarantees!**

## Testing

This package comes with some unit tests under the `tests` directory.
To run all tests you can run the `just test` target.

You need to have ImageMagick installed on your system, which is needed for image comparison.

### Windows
If you are using the [Chocolatey](https://chocolatey.org/) package manager, you can install imagemagick using `choco install imagemagick`.
Otherwise download and install a matching package from the [ImageMagick](https://imagemagick.org/script/download.php) website.

## Acknowledgements
Thank you to...
- [@drupol](https://github.com/drupol) for the `university` theme
- [@Enivex](https://github.com/Enivex) for the `metropolis` theme
- [@MarkBlyth](https://github.com/MarkBlyth) for contributing to the `clean` theme
- [@ntjess](https://github.com/ntjess) for contributing to the height fitting
  feature
- [@JuliusFreudenberger](https://github.com/JuliusFreudenberger) for maintaining
  the `polylux2pdfpc` AUR package
- [@fncnt](https://github.com/fncnt) for coming up with the name "Polylux"
- the Typst authors and contributors for this refreshing piece of software
