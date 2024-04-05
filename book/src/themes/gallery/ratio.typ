#import "../../../../polylux.typ": *

#import themes.ratio: *

#show: ratio-theme.with(
  aspect-ratio: "16-9",
  title: [Ratio theme],
  abstract: [A theme about navigation and customization],
  authors: (ratio-author("Theme Author", "Typst Community", "foo@bar.quux"),),
  version: "1.0.0",
  date: datetime(year: 2024, month: 4, day: 4),
  keywords: ("navigation", "customization"),
  options: (:),
)

#centered-slide[
  = Welcome!
]

#slide[
== Overrides

You can override almost any setting of the theme as you go and switch back
later.

By default link styling is on, but let's force it.

```typ
#ratio-register((style-links: true))
```

#ratio-register((style-links: true))
Results in: #link("https://github.com")[GitHub]

I would like a non-styled link now...

```typ
#ratio-register((style-links: false))
```

#ratio-register((style-links: false))
Results in: #link("https: //github.com")[GitHub]

Feels good right! No lock in.
]

#slide[
  = Customizations

  Some random text at the top of the page to check the margins for non-headers.

  == So much text

  #lorem(50)
]

#slide[
  == Important subsection here!

  - Test an unordered list
    + As well as some enumerations
    + I'm second!
  - More list

  + Followed by more enum at top level
]

#slide[
  = Navigation
  Have you noticed the navigation at the top?

  You can press the main section titles, or just one of the subsection dots.

  == Subsections become dots

  == So there's two dots for "Navigation"!

  And they're both alight since we're on this page.
]

#slide[
  And the last subsection is still active because we haven't registered a new
  section yet!
]

#slide[
You can also manually register a new section using:

```typ
#utils.register-section("Hello world!")
#utils.register-subsection("With a subsec.")
```

#utils.register-section("Hello world!")
#utils.register-subsection("With a subsec.")
]

#slide[
= Overrides

#set text(size: 0.8em)
We all know that layouts work all of the time 99% of the time.

The `ratio-update` function works by updating options (dictionaries) recursively
and thus only updates what you specify.

The `ratio-register` function works by replacing values *completely*.

There's a handy `ratio-palette` variable with a pre-configured color palette,
but feel free to bring your own!

```typ
// Only update the heading color, not it's size:
#ratio-update((title-text: (fill: ratio-palette.warning))) // <- Notice the palette!
// Next title slide will feature a green background.
#ratio-register((title-hero-color: color.hsl(green)))

// Let's add some foreground and background content this time. We can place it anywhere!
#let fg = place(horizon + left, block(inset: 10%, width: 100%)[foreground.])
#let bg = place(
  horizon + left,
  block(inset: 30%, width: 100%)[#text(weight: "bold")[background.]],
)
#title-slide(title: "Green", register-section: true, foreground: fg, background: bg)

// This becomes...=>
```
]
#ratio-update((title-text: (fill: ratio-palette.warning)))
#ratio-register((title-hero-color: color.hsl(green)))
#let fg = place(horizon + left, block(inset: 10%, width: 100%)[foreground.])
#let bg = place(
  horizon + left,
  block(inset: 30%, width: 100%)[#text(weight: "bold")[background.]],
)
#title-slide(title: "Green", register-section: true, foreground: fg, background: bg)
