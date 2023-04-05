# Themes
The `typst-slides` template also supports theming.
By default, the theme `slides-default-theme` is used.
You can specify the use of another one in the initial `slides` statement:
```typ
#show: slides(
  author: "...",
  title: "...",
  // ...
  theme: your-fancy-theme(with, some, options),
)
```

## Theme variants per slide
The `#slide` function has an optional argument `theme-variant`.
You can use it to select one of the variants your current theme provides, so
that this specific slide will look different.
```typ
#slide(theme-variant: "variant name")[
  ...
]
```

## Create your own theme
On a high level, a theme is nothing more than a piece of code that defines how
the title slide looks and at least one variant defining how the content slides
look.

On one level deeper, a theme is a function that takes a `data` dictionary and
returns a dictionary with the keys `title-slide` and `variants`.
Let us build a very simple one for demonstration purposes:
```typ
#let dumb-theme = data => {
  (
    title-slide: ...,
    variants: ...,
  )
}
```
Note that you can easily introduce parameters to your theme:
```typ
#let dumb-theme(parameter) = data => {
  (
    title-slide: ...,
    variants: ...,
  )
}
```

The `data` dictionary provides you with all the information that the user has
set in the initial `slides` function, i.e. it has the following structure:
```typ
(
  author: ...,
  title: ...,
  short-author: ...,
  short-title: ...,
  date: ...,
)
```
Use these information however you please.

For example, you could define the title slide in the following way:
```typ
#let dumb-theme = data => {
  (
    title-slide: align(center + horizon, data.title),
    variants: ...,
  )
}
```

On to the actual slides.
Their appearance is defined by functions that accept some content (the last
argument to `#slide`, essentially) and return some richer content, somehow
styling that slide.
You can define an arbitrary amount of such functions as values of the `variants`
dictionary, but one of them must be stored under the key `"default"`.

To make use of some of the functionality this template offers, you can access
- the counter `logical-slide`, telling you the "page number" of a slide, but
  without counting up on dynamical slides that produce mulitple PDF pages;
- the state `section`, telling you what the user has currently set as the
  section name.

Let us define two variants:
```typ
#let dumb-theme = data => {
  (
    title-slide: align(center + horizon, data.title),
    variants: (
      "default": body => {
        text(.7em, [current section: #section.display()])
        v(1fr)
        body
        v(1fr)
        text(.7em, [#h(1fr) #logical-slide.display()])
      },
      "australia": body => {
        text(.7em, [current section: #section.display()])
        v(1fr)
        scale(y: -100%, body)
        v(1fr)
        text(.7em, [#h(1fr) #logical-slide.display()])
      },
    ),
  )
}
```
And that's it already!
Have fun creating your own theme and maybe consider opening a pull request
at [the GitHub repository](https://github.com/andreasKroepelin/typst-slides)
to share your creations!