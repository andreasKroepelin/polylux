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
- `typography`: an optional dictionary that can have any of the following entries:
  - `paper`: this value is propagated to a `#set page(paper: ...)` command, use
     if to specify another paper size than the default `"presentation-16-9"`
     (probably only `"presentation-4-3"` makes sense, though)
  - `text-size`: the baseline font size of text on your slides, headings etc.
    will have sizes relative to that (default is `25pt`)
  - `text-font`: the font to use for text on your slides, you can also specify
    an array of fonts
    ([see the Typs docs](https://typst.app/docs/reference/text/text/#parameters--font)).
    The default array is `( "Inria Sans", "Libertinus Sans", "Latin Modern Sans" )`.
  - `math-font`: similar to `text-font` above, but for math typesetting.
    The default array is `( "GFS Neohellenic Math", "Fira Math", "TeX Gyre Pagella Math", "Libertinus Math" )`.

The data you provide in this configuration is propagated to the
[theme](./themes.html) which then decides how to display all that.

