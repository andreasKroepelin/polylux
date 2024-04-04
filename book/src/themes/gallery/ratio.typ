#import "../../../../polylux.typ": *

#import themes.ratio: *

#show: ratio-theme.with(
  title: [Ratio theme],
  abstract: [A theme about navigation and customization],
  authors: (author("Theme Author", "Typst Community", "foo@bar.quux"),),
  navigation-text: (fill: palette.secondary-200, size: 0.4em),
  version: "1.0.0",
  date: datetime(year: 2024, month: 4, day: 4),
)

#slide[
  #block(width: 100%, height: 100%)[
    #place(horizon + center)[= Welcome!]
  ]
]

#slide[
== Overrides

You can override almost any setting of the theme as you go and switch back
later.

By default link styling is on, but let's force it.

```typ
#register-options((style-links: true))
```

#register-options((style-links: true))
Results in: #link("https://github.com")[GitHub]

I would like a non-styled link now...

```typ
#register-options((style-links: false))
```

#register-options((style-links: false))
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

We all know that layouts work all of the time 99% of the time.

To turn off or change some of Ratio's slides on those occasions, you can use:

```typ
// Next title slide will feature a green background.
#register-options((title-background-color: color.hsl(green)))

// Let's add some raw content this time. We can place it anywhere!
#let raw = align(horizon + center, "raw.")
#title-slide(title: "Green", register-section: true, content: raw)
```
]

// Next title slide will feature a green background.
#register-options((title-background-color: color.hsl(green)))

// Let's add some raw content this time. We can place it anywhere!
#let raw = align(horizon + center, "raw.")
#title-slide(title: "Green", register-section: true, content: raw)
