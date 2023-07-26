# Internals
Here, topics regarding the internal implementation of dynamic content in polylux
is discussed.
Usually, you can completely ignore this section.

## Internal number of repetitions
**TL;DR:**
For slides with more than ten subslides, you need to set the `max-repetitions`
argument of the `#polylux-slide` function to a higher number.

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
[creating an issue](https://github.com/andreasKroepelin/polylux/issues)
so we can discuss this.)

For those hopefully rare occasions where you do, in fact, need more than ten
subslides, you can manually increase this number using the `max-repetitions`
argument of the `#slide` function:
```typ
#polylux-slide(max-repetitions: 20)[
  This is gonna take a while:
  #uncover(20)[I can wait...]
]
```

Again, use this feature sparingly, as it decreases typesetting performance.

