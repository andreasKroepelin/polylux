# Theme Gallery

Here you can find an overview over all themes shipped with this template.

- [Default](#default)
- [Bipartite](#bipartite)

---

## Default
_[go to top](#theme-gallery)_

If you do not specify a theme, the default one will be used.
You can specify it explicitly by referring to `slides-default-theme`:
```typ
#show: slides(
  // ...
  theme: slides-default-theme(color: your-favourite-color)
)
```
### Options
- `color`: the color to use for decorative elements, default `teal`

### Variants
- `"wake up"`: no decoration, colored background, enlarged text

### Extra keyword arguments
- `title`: a title for that slide

### Showcase
```typ
#import "slides.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
)

#new-section("section name")

#slide(title: "Slide title")[
  A slide
]

#slide(theme-variant: "wake up")[
  Wake up!
]
```
![default theme screenshot](./default.png)

---

## Bipartite
_[go to top](#theme-gallery)_

This theme is inspired by
[Modern Annual Report](https://slidesgo.com/theme/modern-annual-report).
It features a dominant partition of space into a bright and a dark side.
```typ
#import "themes/bipartite.typ": *
#show: slides(
  // ...
  theme: bipartite-theme(),
)
```
### Options
- *none*

### Variants
- `"east"`: same as default variant, but dark side on the right, text is right
  aligned
- `"center split"`: bright left and dark right half of equal size, requires two
  content bodies, one for each half (does not display a slide title)

### Extra keyword arguments
- `title`: a title for that slide

### Showcase
```typ
#import "slides.typ": *
#import "themes/bipartite.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: bipartite-theme(),
)

#new-section("section name")

#slide(title: "A longer slide title")[
  #lorem(40)
]

#slide(theme-variant: "east", title: "On the right!")[
  #lorem(40)
]

#slide(theme-variant: "center split")[
  #lorem(40)
][
  #lorem(40)
]
```
![bipartite theme screenshot](./bipartite.png)

