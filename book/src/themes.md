# Themes
The `polylux` template also supports theming.
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
the slides look.

On one level deeper, a theme is a function that takes a `data` dictionary and
returns a dictionary with one key for each _variant_.
Let us build a very simple one for demonstration purposes:
```typ
#let dumb-theme = data => {
  (
    "variant 1": ...,
    "variant 2": ...,
  )
}
```
Note that you can easily introduce parameters to your theme:
```typ
#let dumb-theme(parameter) = data => {
  (
    "variant 1": ...,
    "variant 2": ...,
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

On to the actual slides.
Their appearance is defined by functions that accept some meta data, some
array of contents (the last argument(s) to `#slide`, essentially) and return
some richer content, somehow styling that slide:
```typ
(dictionary, array of content) => content
```
We call these functions the _variants_ of the theme.
You can define an arbitrary amount of them but one must be stored under the key
`"default"` in your theme.

The meta data referred to above are a dictionary containing any extra keyword
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

The `#slide` function accepts an arbitrary amount of positional arguments that
are interpreted as content for the slide.
The user of this template can provide them by simply juxtapositioning multiple
content blocks after `#slide` or `#slide(...)`, see
[this section](./slide.html#slides-with-multiple-content-bodies).
Often, it will make sense to work with only a single piece of content,
however.
In any case, your variant function will always be provided an array of contents
as the second argument, so you will usually have to extract that single entry
you are interested in (using `.at(0)` or `.first()`).
It might also make sense to `panic` with an informative error message if the user
provided another number of content blocks than you expected.


To make use of some of the functionality this template offers, you can access
- the counter `logical-slide`, telling you the "page number" of a slide, but
  without counting up on dynamical slides that produce mulitple PDF pages;
- the state `section`, telling you what the user has currently set as the
  section name.

Let us define a few variants variants.
You should probably add a variant for a title slide to your theme.
By convention, this variant is called `"title slide"`.
```typ
#let dumb-theme = data => {
  (
    "title slide": (slide-info, bodies) => align(center + horizon, data.title),
    "variant 2": ...,
  )
}
```
As noted above, one of the variants must have the name `"default"`.

```typ
#let dumb-theme = data => {
  (
    "title slide": (slide-info, bodies) => align(center + horizon, data.title),
    "default": (slide-info, bodies) => {
      text(.7em, [#slide-info.title (current section: #section.display())])
      v(1fr)
      for body in bodies {
        body
        v(1em)
      }
      v(1fr)
      text(.7em, [#h(1fr) #logical-slide.display()])
    },
    "australia": (slide-info, bodies) => {
      if bodies.len() != 1 {
        panic("australia variant expected exactly one body")
      }
      text(.7em, [current section: #section.display()])
      v(1fr)
      scale(y: -100%, bodies.first())
      v(1fr)
      text(.7em, [#h(1fr) #logical-slide.display()])
    },
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

Also, the `"default"` variant displays all the content blocks provided to `#slide`
while the `"australia"` variant errors if more or less than one such block is
given.

The `"title slide"` variant uses neither the `slide-info` nor the `bodies`.
That is a usual behaviour, as title slides normally only depend on the general
information like author, presentation title, etc.

And that's it already!
Have fun creating your own theme and maybe consider opening a pull request
at [the GitHub repository](https://github.com/andreasKroepelin/polylux)
to share your creations!

## Per-slide escape hatch
In some exceptional situations, the machinery of themes and theme variants might
be too limited for what you need.
Sometimes, you might find yourself needing a very special purpose design _just_
for a couple of slides.
For that case, you can use the `override-theme` argument of the `#slide` function.
It accepts a function of the form `(slide-info, bodies) => [slide content]`, just
as if you would define a theme variant (see details above).

For example, you might write something like this:
```typ
#let special-purpose-theme(slide-info, bodies) = align(horizon)[
  #rotate(45deg, heading(level: 2, slide-info.title))
  #scale(x: -100%, bodies.first())
]
#slide(override-theme: special-purpose-theme, title: "This is rotated")[
  #lorem(40)
]
```

If you feel like your use of this feature becomes more than exceptional, consider
contributing a variant to the theme you use, or a new theme entirely.