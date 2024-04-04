# Ratio theme

![ratio](ratio.png)

This theme is inspired by the Singapore beamer theme. It has a more modern look, but still features Singapore's navigation sections and sub-section circles.

Use it via

```typ
{{#include ../../IMPORT.typ}}
#import themes.ratio: *

#show: ratio-theme.with(
  title: [Ratio theme],
  abstract: [A theme about navigation and customization],
  authors: (author("The Author", "Typst Community", "foo@bar.quux"),),
  navigation-text: (fill: palette.secondary-200, size: 0.4em),
  version: "1.0.0",
  date: datetime(year: 2024, month: 4, day: 4),
)
```

By default it already generates a cover page and sets some document attributes based on your settings.

`ratio` uses polylux' section handling, the regular `#outline()` will not work
properly, use `#polylux-outline` instead.

## Options for initialization

The theme is highly customizable! If there's something you don't like or want to tweak, you probably can.

### The basics

- `title`: Presentation title content
- `abstract`: An abstract or subtitle for your work. Can be none to disable.
- `authors`: An array of objects made with the custom `author(name:, affiliation:, email: )` method.
- `date`: A datetime object, defaults to today.
- `keywords`: Output document keywords to set.
- `version`: A document version to display. Something like "Draft" or "1.0".

### The tweaks

- `style-headings`: Enable/disable any styling applied to headings.
- `style-links`: Enable/disable any styling applied to links.
- `header`: What to display as the header ("navigation", "progress", content, or none).
- `footer`: What to display as the footer ("navigation", "progress", content, or none).
- `title-background-color`: Tweak the background color for the coming title pages.
- `title-text`: Styling to apply to the entire title page's text.
- `link-color`: The color to apply to the link anchor.
- `heading-color`: The color to apply to headings.
- `stroke-color`: The color to apply to strokes such as in tables.
- `fill-color`: The color to apply in fills such as in code blocks.
- `navigation-bar-color`: Navigation background color.
- `navigation-text`: Navigation bar text options for all text.
- `navigation-text-past`: Navigation bar text overrides for past sections.
- `navigation-text-current`: Navigation bar text overrides for the current section.
- `navigation-text-future`: Navigation bar text overrides for future sections.
- `navigation-shape-past`: Navigation bar shape for past subsections.
- `navigation-shape-current`: Navigation bar shape for current subsections.
- `navigation-shape-future`: Navigation bar shape for future subsections.
- `progress-bar-height`: Progress bar height.
- `progress-bar-color`: Progress bar background color.
- `progress-overlay-color`: Progress bar overlay color.
- `progress-text-color`: Progress bar text color.

## Additional features

We all know that themes and styles work all of the time 99% of the time.
Ergo, if you would like to (temporarily) turn off the "link anchor" that `ratio` creates, you can do so:

```typ
#register-options((style-links: false))
```

Any of the initialization options works this way!

## Example code

The image at the top is created by the following code:

```typ
{{#include ../../IMPORT.typ}}
{{#include ratio.typ:3:}}
```
