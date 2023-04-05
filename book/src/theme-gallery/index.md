# Theme Gallery

Here you can find an overview over all themes shipped with this template.

## Default
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

### Showcase
```typ
#import "slides.typ": *

#show: slides.with(
    author: "Author", short-author: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
)

#new-section("section name")

#slide[
  A slide
]

#slide(theme-variant: "wake up")[
  Wake up!
]
```
![default theme screenshot](./default.png)
