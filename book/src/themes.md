# Themes
The `typst-slides` template also supports theming.
By default, the theme `slides-default-theme` is used.
You can specify the use of another one in the initial `slides` statement:
```typ
#show: slides(
  authors: "...",
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
  subtitle: ...,
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
Their appearance is defined by functions that accept some meta data, some
content (the last argument to `#slide`, essentially) and return some richer
content, somehow styling that slide.
You can define an arbitrary amount of such functions as values of the `variants`
dictionary, but one of them must be stored under the key `"default"`.

The meta data referred to above are a dictionary containing any extra keyword-
arguments that the user has specified in their call to `#slide`.
As a theme author, you should inform your users what kind of arguments you will
respect.
You should access that data defensively and not expect that users provide any
of the extra arguments you can consume.
Similarly, you should not expect that the meta data exclusively contains keys
you respect.
For example, if a user states
```typ
#slide(funny-kwarg: "some value", theme-variant: "a variant", something-else: "wohoo")[
  ...
]
```
then your styling function will be provided the following dictionary:
```typ
(
  funny-kwarg: "some value",
  something-else: "wohoo",
)
```
especially not containing a `theme-variant` item!

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
      "default": (slide-info, body) => {
        text(.7em, [#slide-info.title (current section: #section.display())])
        v(1fr)
        body
        v(1fr)
        text(.7em, [#h(1fr) #logical-slide.display()])
      },
      "australia": (slide-info, body) => {
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
We can see that the `"default"` variant expects that users provide a `title`
keyword argument to `#slide`.
(Note again that this is bad practise and you should provide some fallback
behaviour if some arguments you expect are not provided.)
The `"australia"` variant does not make use of the `slide-info` argument at all.
That is completely fine, it must have this argument for formal reasons, anyway,
though.

And that's it already!
Have fun creating your own theme and maybe consider opening a pull request
at [the GitHub repository](https://github.com/andreasKroepelin/typst-slides)
to share your creations!

## Per-slide escape hatch
In some exceptional situations, the machinery of themes and theme variants might
be too limited for what you need.
Sometimes, you might find yourself needing a very special purpose design _just_
for a couple of slides.
For that case, you can use the `override-theme` argument of the `#slide` function.
It accepts a function of the form `(slide-info, body) => [slide content]`, just
as if you would define a theme variant (see details above).

For example, you might write something like this:
```typ
#let special-purpose-theme(slide-info, body) = align(horizon)[
  #rotate(45deg, heading(level: 2, slide-info.title))
  #scale(x: -100%, body)
]
#slide(override-theme: special-purpose-theme, title: "This is rotated")[
  #lorem(40)
]
```

If you feel like your use of this feature becomes more than exceptional, consider
contributing a variant to the theme you use, or a new theme entirely.