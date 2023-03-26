# Dynamic slides
This template offers basic support for dynamic slides with changing content.
That means you can show or hide parts of a slide at different points in time.
Using this feature requires using the `#slide` function.
To restrict the visiblity of content to certain "subslides", use one of the
following function:

- `#only(2)[content]`: content is only visible on 2nd subslide
- `#until(3)[content]`: content is only visible on 1st, 2nd, and 3rd subslide
- `#beginning(2)[content]`: content is visible from the 2nd subslide onwards
- `#one-by-one(start: 2)[one][two][three]`: uncover `one` on the 2nd slide, then
  `two` on the 3rd slide, and then `three` on the 4th slide. You can specify an
   arbitrary number of contents. The `start` argument is optional.
   `#one-by-one[x][y]` will uncover `x` on the first subslide.

Let's see this in action:
```typ
#slide[
  always visible
  #only(1)[only visible on the first subslide]
  #beginning(2)[only visible on the second subslide]
]
```

The number of subslides (number of PDF pages produced) one logical slide is
converted two depends on the highest subslide index you specified content to
appear or disappear.

Note that the same page number is displayed for all subslides of a logical slide.

## Cover mode
You can decide if you want covered content to be completely hidden (the default)
or if you want it to be visible but muted (printed in a light gray).
Switch between the two modes by using
```typ
#cover-mode-hide // covered content is hidden completely
#cover-mode-mute // covered content is visible but muted
```