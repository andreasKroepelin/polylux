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
![title slide](assets/simple.png)

As you can see, creating slides is as simple as using the `#slide` function.
You can also use different
[themes](https://andreaskroepelin.github.io/polylux/book/theme-gallery/index.html)
(contributions welcome if you happen to
[create your own](https://andreaskroepelin.github.io/polylux/book/themes.html#create-your-own-theme)!)

For dynamic content, the template also provides [a convenient API for complex
overlays](https://andreaskroepelin.github.io/polylux/book/dynamic.html).

Visit the
[book](https://andreaskroepelin.github.io/polylux/book)
for more details or take a look at the
[demo PDF](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)
where you can see the features of this template in action.

**⚠ This template is in active development.
While I try to make sure that the `main`-branch always is in a usable state,
there are no compatibility guarantees!**
