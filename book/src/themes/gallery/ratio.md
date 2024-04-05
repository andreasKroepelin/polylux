# Ratio theme

![ratio](ratio.png)

This theme is inspired by the Singapore beamer theme. It has a more modern look, but still features Singapore's navigation sections and sub-section circles.

Use it via

```typ
{{#include ../../IMPORT.typ}}
#import themes.ratio: *

#show: ratio-theme.with(
  aspect-ratio: "16-9",
  title: [Ratio theme],
  abstract: [A theme about navigation and customization],
  authors: (ratio-author("Theme Author", "Typst Community", "foo@bar.quux"),),
  version: "1.0.0",
  date: datetime(year: 2024, month: 4, day: 4),
  keywords: ("foo", "bar"),
  options: (:),
)
```

By default it already generates a cover page and sets some document attributes based on your settings.
You can disable this with `cover: false`.

`ratio` uses polylux' section handling, the regular `#outline()` will not work
properly, use `#polylux-outline` instead.

## Options for initialization

The theme is highly customizable! If there's something you don't like or want to tweak, you probably can.

### The essentials

The essentials are separate keyword arguments to the `ratio-theme` call.

- `aspect-ratio`: The aspect ratio (16-9 by default).
- `cover`: Wether to include the cover page.
- `title`: Presentation title content
- `abstract`: An abstract or subtitle for your work. Set to `none` to disable.
- `authors`: An array of objects made with the custom `author(name:, affiliation:, email: )` method.
- `date`: A datetime object, defaults to today.
- `version`: A document version to display. Something like "Draft" or "1.0".
- `keywords`: Output document keywords to set.

### The `options` tweaks

The `options` keyword argument is special, it takes a dictionary with any of the following:

- `style-headings`: Enable/disable any styling applied to headings.
- `style-links`: Enable/disable any styling applied to links.
- `style-raw`: Enable/disable any styling applied to raw content.
- `header`: What to display as the header ("navigation", "progress", content, or `none`).
- `footer`: What to display as the footer ("navigation", "progress", content, or `none`).
- `title-background-color`: Tweak the background color for the coming title pages.
- `title-text`: Styling to apply to the entire title page's text.
- `heading-text`: The style to apply to heading text.
- `link-color`: The color to apply to the link anchor.
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

## Slide functions

`ratio` provides the following custom slide functions:

- `title-slide(title, authors, abstract, date, version, keywords, foreground, background, register-section)` with all keyword arguments:
  - `title`: Presentation title content. Defaults to `none`.
  - `abstract`: An abstract or subtitle for your work. Defaults to `none`.
  - `authors`: An array of objects made with the custom `author(name:, affiliation:, email: )` method. Defaults to `none`.
  - `date`: A datetime object, defaults to `none`.
  - `version`: A document version to display on the date line. Something like "Draft" or "1.0". Defaults to `none`.
  - `keywords`: Keywords to display on the date line. Defaults to ().
  - `foreground`: Content to include in front of the default text content.
  - `background`: Content to include behind the default text content.
  - `hero`: Whether to draw the default hero image (uses `options.title-hero-color`).
  - `register-section`: Whether the given title should be registered as a section in the outline and navigation.
- `slide(title, header, footer)[body]` with a title keyword argument and body positional.
  - `title`: Section title will be added as a heading, too. Mostly for compatibility purposes with other themes.
  - `header`: Header content override. Default is `auto` which draws the header according to the theme options. Set it to `none` to disable for this slide.
  - `footer`: Footer content override. Default is `auto` which draws the footer according to the theme options. Set it to `none` to disable for this slide.
  - `body`: Your content such that you can type `#slide[my foo is my bar]`
- `centered-slide(header, footer)[body]`

- `bare-slide[body]`: For now just an alias of `polylux-slide`

See the [Customization](#customization) feature for ways to change these on the fly!

## Additional features

### Palette

Do you like theme colors? Ratio includes a default palette to pull from in the `ratio-palette` variable. That should make it easier to style things!

### Customization

Ratio's key feature is customization. It stores all it's options in a `ratio-options` state variable. You probably won't interact with that variable directly, but its defaults are included as the `ratio-defaults` variable for you to inspect!

```typ
// Careful, there are a lot of options!
#ratio-defaults
```

You can change the options in one of two ways:

```typ
// Register: replaces the option values given in this dictionary completely.
// For example, this disables the link styling with the little anchor:
#register-options((style-links: false))

// Update: recursively updates any dictionaries (i.e. for `text()` related items).
// For example, this only replaces the title text's fill and leaves other options intact.
#update-options((title-text: (fill: ratio-palette.danger)))
```

You can put these overrides halfway through your document to change things on the fly!

## Example code

The image at the top is created by the following code:

```typ
{{#include ../../IMPORT.typ}}
{{#include ratio.typ:3:}}
```
