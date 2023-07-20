# Polylux
This is a template for creating slides in [Typst](https://typst.app/).

[![Book badge](https://img.shields.io/badge/docs-book-green)](https://andreaskroepelin.github.io/polylux/book)
![GitHub](https://img.shields.io/github/license/andreasKroepelin/polylux)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/andreasKroepelin/polylux)
[![Demo badge](https://img.shields.io/badge/demo-pdf-blue)](https://github.com/andreasKroepelin/polylux/releases/latest/download/demo.pdf)

## Quickstart
```typ
#import "polylux.typ": *

#show: slides.with(
    authors: "Names of author(s)",
    short-authors: "Shorter author for slide footer",
    title: "Title of the presentation",
    subtitle: "Subtitle of the presentation",
    short-title: "Shorter title for slide footer",
    date: "March 2023",
)

#set text(font: "Inria Sans", size: 25pt)

#slide(theme-variant: "title slide")

#new-section("My section name")

#slide(title: "A boring static slide")[
  Some boring static text.

  #lorem(20)
]

#slide[
  A fancy dynamic slide without a title.
  #uncover("2-")[This appears later!]
]

#slide(theme-variant: "wake up")[
  Focus!
]

#new-section("Conclusion")

#slide(title: "Take home message")[
  Read the book!

  Try it out!

  Create themes!
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
