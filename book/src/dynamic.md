# Dynamic slides
This template offers basic support for dynamic slides with changing content.
That means you can show or hide parts of a slide at different points in time.
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
converted to depends on the highest subslide index you specified content to
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
## Internal number of repetitions
**TL;DR:**
For slides with more than ten subslides, you need to set the `max-repetitions`
argument of the `#slide` function to a higher number.
Usually, you can completely ignore this section, though.

For technical reasons (this might change in the future when we find a better
solution), producing PDF pages for subslides is implemented in the following way:
Each dynamic element, such as `#only` or `#beginning` "knows" how many subslides a
logical slide must have for it to "make sense".
For example, a `#beginning(5)[...]` only makes sense if at least 5 subslides are
produced.

Internally, when typesetting a slide, we now look at all the dynamic elements in
it and find the maximum of those individual "required" subslide counts.
So if a slide contains a `#only(2)[...]`, a `#until(4)[...]`, and nothing else,
we know that exactly 4 subslides are necessary.

However, we only acquire this knowledge _after_ the first subslide has been
produced, i.e. when all of the slide's content has been "looked at" once.
This is why we cannot simply implement something like "produce 4 pages by
iterating this loop 4 times".
Instead, the (admittedly hacky) solution is to iterate "very often" and check in
each iteration if we still need to produce another page.
This works because we always need to produce at least one page for a slide, so
we can unhurriedly inspect all dynamic elements and find the maximum subslide
count at the first iteration.
After that, we have the information we need.

Now, the question arises how often "very often" should be.
This requires a trade-off:
Iterating too few times (say, twice) will lead to frequent situations where we
ignore dynamic behaviour that was supposed to happen in later subslides (say, in
the third).
Iterating, say, a thousand times means that we will practically never encounter
such situations but we now perform a thousand iterations _per slide_.
Especially when you want to see a live update of your produced PDF as you type,
this leads to severe lagging that somewhat defeats the purpose of Typst's speed.
(Still faster than LaTeX, though...)

It appears reasonable that occasions are rare where one needs more than ten
subslides for one slide.
Therefore, ten is the default value for how often we try to create a new subslide.
This should not produce noticable lag.
(If it does for you, consider
[creating an issue](https://github.com/andreasKroepelin/typst-slides/issues)
so we can discuss this.)

For those hopefully rare occasions where you do, in fact, need more than ten
subslides, you can manually increase this number using the `max-repetitions`
argument of the `#slide` function:
```typ
#slide(max-repetitions: 20)[
  This is gonna take a while:
  #until(20)[I can wait...]
]
```

Again, use this feature sparingly, as it decreases typesetting performance.