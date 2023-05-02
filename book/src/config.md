# Configuration
When initialising your document with `#show: slides.with(...)`, you can (but
don't have to) provide the following arguments in the form of
```typ
#show: slides.with(
  title: "some string",
  subtitle: [contents are also possible],
  // ...
)
```

- `title`: the title of your presentation, you should probably specify this
- `subtitle`: a subtitle giving a bit of context to the title, not always necessary
- `short-title`: an abbreviated version of the title that is suitable to be shown
  on every slide, for example in the footer
- `authors`: either a string or content naming or describing the author, or an
  array of strings or contents naming or describing multiple authors
- `short-authors`: an abbreviated version of the authors (as one string or content)
  that is suitable to be shown on every slide
- `date`: some kind of spatio-temporal information about when or where your talk
  takes place
- `theme`: set a theme other than the default, see [this section](./themes.html)
- `aspect-ratio`: either `"16-9"` (default) or `"4-3"` to specify if you want
  PDF pages with aspect ratio 16:9 or 4:3
- `handout`: either `true` or `false` (default), set whether you want to produce
  a handout version of these slides (see [this section](./dynamic.html#handout-mode))

The data you provide in this configuration is propagated to the
[theme](./themes.html) which then decides how to display all that.

## A note on the font size
Typst-slides will use a default font size of 25 pt.
If you want to use another one, specify that _after_ the template show-rule, i.e.:
```typ
#show: slides.with(
  // ...
)
#set text(size: 20pt)
```
It is overwritten if you put the `#set text(...)` before.
