# Creating slides
To fill your presentation with content, you can use the `#slide` function.
The only required argument is some content that is supposed to be displayed on
the slide, so in the simplest case you can just write
```typ
#slide[
  Your slide content
]
```

However, there are a couple optional keyword arguments you can provide in the
form of
```typ
#slide(key: value)[
  Your slide content
]
```
These are:
- `theme-variant`: when you want this slide to look slightly different, see
  [here](./themes.html#theme-variants-per-slide)
- `override-theme`: when you want this slide to look completely different, see
  [here](./themes.html#per-slide-escape-hatch)
- `max-repetitions`: when you create a slide with a _lot_ of dynamic content,
  see [here](./dynamic.html#internal-number-of-repetitions)
- additional information used by the theme, see the [gallery](./theme-gallery/index.html)
  to find out which they are under your theme's "Extra keyword arguments" section
  (typically, you can at least specify a slide title as `title`)

## Slides with multiple content bodies
In the vast majority of cases, you will call `#slide` the way described above
with one content block.
However, some [themes](./themes.html) (or some of their
[variants](./themes.html#theme-variants-per-slide)) sometimes require or allow
more than one such content.
In that case, you will write:
```typ
#slide[
  The first piece of content
][
  Even more content
][
  Who knows how much content we can come up with?
]
```