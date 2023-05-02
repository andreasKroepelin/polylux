# Dynamic slides

The PDF format does not (trivially) allow to include animations, as one would be
used to from, say, Powerpoint.
The solution PDF-based presentation slides use is to create multiple PDF pages
for one slide, each with slightly different content.
This enables us to have some basic dynamic elements on our slides.

In this book, we will use the term _logical slide_ for a section of content that
was created by one call to `#slide`, and _subslide_ for a resulting PDF page.
Each logical side can have an arbitrary amount of subslides and every subslide
is part of exactly one logical slide.
Note that the same page number is displayed for all subslides of a logical slide.


In the LaTeX beamer package, the functionalities described on this page are
called "overlays".

## Reserve space or not?
When you want to specify that a certain piece of content should be displayed one
some subslides but not on others, the first question should be what should happen
on the subslides it is _not_ displayed on.
You could either want
- that it is completely not existing there, or
- that it is invisible but it still occupies the space it would need otherwise
  (see [the docs of the `#hide` function](https://typst.app/docs/reference/layout/hide/))

The two different behaviours can be achieved using either `#only` or `#uncover`,
respectively.
The intuition behind it is that, in one case, content is _only_ existing on some
slides, and, in the other case, it is merely _covered_ when not displayed.

## General syntax for `#only` and `#uncover`
Both functions are used in the same way.
They each take two positional arguments, the first is a description of the
subslides the content is supposed to be shown on, the second is the content itself.
Note that Typst provides some syntactic sugar for trailing content arguments,
namely putting the content block _behind_ the function call.

You could therefore write:
```typ
#only(2)[Some content to display only on subslide 2]
#uncover(3)[Some content to uncover only on subslide 3]
```

In this example, we specified only a single subslide index, resulting in content
that is shown on that exact subslide and at no other one.
Let's explore more complex rules next:

## Complex display rules
There are multiple options to define more complex display rules.

### Array
The simplest extension of the single-number case is to use an array.
For example
```typ
#uncover((1, 2, 4))[...]
```
will uncover its content on the first, second and fourth subslide.
The array elements can actually themselves be any kind of rule that is explained
on this page.

### Interval
You can also provied a (bounded or half-bounded) interval in the form of a
dictionary with a `beginning` and/or an `until` key:
```typ
#only((beginning: 1, until: 5)[Content displayed on subslides 1, 2, 3, 4, and 5]
#only((beginning: 2))[Content displayed on subslide 2 and every following one]
#only((until: 3))[Content displayed on subslides 1, 2, and 3]
#only((:))[Content that is always displayed]
```
In the last case, you would not need to use `#only` anyways, obviously.

### Convenient syntax as strings
In principle, you can specify every rule using numbers, arrays, and intervals.
However, consider having to write
```typ
#uncover(((until: 2), 4, (beginning: 6, until: 8), (beginning: 10)))[...]
```
That's only fun the first time.
Therefore, we provide a convenient alternative.
You can equivalently write:
```typ
#uncover("-2, 4, 6-8, 10-")[...]
```
Much better, right?
The spaces are optional, so just use them if you find it more readable.

Unless you you are creating those function calls programmaticly, it is a good
recommendation to use the single-number syntax (`#only(1)[...]`) if that
suffices and the string syntax for any more complex use case.

## Higher level helper functions
With `#only` and `#uncover` you can come a long way but there are some reoccurring
situations for which helper functions are provided.

### `#one-by-one` and `#line-by-line`
Consider some code like the following:
```typ
#uncover("1-")[first ]
#uncover("2-")[second ]
#uncover("3-")[third]
```
The goal here is to uncover parts of the slide one by one, so that an increasing
amount of content is shown.
A shorter but equivalent way would be to write
```typ
#one-by-one[first ][second ][third]
```

And what about this?
```typ
#uncover("3-")[first ]
#uncover("4-")[second ]
#uncover("5-")[third]
```
Now, we still want to uncover certain elements one after the other but starting
on subslide 3.
We can use the optional `start` argument of `#one-by-one` for that:
```typ
#one-by-one(start: 3)[first ][second ][third]
```

`#one-by-one` is especially useful for arbitrary contents that you want to display
in that manner.
Often, you just want to do that with very simple elements, however.
A very frequent use case are bullet lists.
Instead of
```typ
#one-by-one[
  - first
][
  - second
][
  - third
]
```
you can also write
```typ
#line-by-line[
  - first
  - second
  - third
]
```
The content provided as an argument to `#line-by-line` is parsed as a `sequence`
by Typst with one element per line (hence the name of this function).
We then simply iterate over that `sequence` as if it were given to `#one-by-one`.

Note that there also is an optional `start` argument for `#line-by-line`, which
works just the same as for `#one-by-one`.

### `pause` as an alternative to `#one-by-one`
There is yet another way to solve the same problem as `#one-by-one`.
If you have used the LaTeX beamer package before, you might be familiar with the
`\pause` command.
It makes everything after it on that slide appear on the next subslide.

Remember that the concept of "do something with everything after it" is covered
by the `#show: ...` mechanism in Typst.
We exploit that to use the `pause` function in the following way.
```typ
Show this first.
#show: pause(2)
Show this later.
#show: pause(3)
Show this even later.
#show: pause(4)
That took aaaages!
```
This would be equivalent to:
```typ
#one-by-one[
  Show this first.
][
  Show this later.
][
  Show this even later.
][
  That took aaaages!
]
```
It is obvious that `pause` only brings an advantage over `#one-by-one` when you
want to distribute a lot of code onto different subslides.

**Hint:**
You might be annoyed by having to manually number the pauses as in the code
above.
You can diminish that issue a bit by using a counter variable:
```typ
Show this first.
#let pc = 1 // `pc` for pause counter
#{ pc += 1 } #show: pause(pc)
Show this later.
#{ pc += 1 } #show: pause(pc)
Show this even later.
#{ pc += 1 } #show: pause(pc)
That took aaaages!
```
This has the advantage that every `pause` line looks identical and you can move
them around arbitrarily.
In later versions of this template, there could be a nicer solution to this
issue, hopefully.

### `#alternatives` to substitute content
The so far discussed helpers `#one-by-one`, `#line-by-line`, and `pause` all
build upon `#uncover`.
There is an analogon to `#one-by-one` that is based on `#only`, namely
`#alternatives`.
You can use it to show some content on one subslide, then substitute it by
something else, then by something else, etc.

Consider this example:
```typ
#only(1)[Ann] #only(2)[Bob] #only(3)[Christopher]
likes
#only(1)[chocolate] #only(2)[strawberry] #only(3)[vanilla]
ice cream.
```
Here, we want to display three different sentences with the same structure:
Some person likes some sort of ice cream.
Using `#only`, the positioning of `likes` and `ice cream` moves around in the
produced slide because, for example, `Ann` takes much less space than
`Christopher`.
This somewhat disturbs the perception of the constant structure of the sentence
and that only the names and kinds of ice cream change.

To avoid such movement and only subsitute certain parts of content, you can use
the `#alternatives` function.
With it, our example becomes:
```typ
#alternatives[Ann][Bob][Christopher]
likes
#alternatives[chocolate][strawberry][vanilla]
ice cream.
```

`#alternatives` will put enough empty space around, for example, `Ann` such that
it usese the same amount of space as `Christopher`.
In a sense, it is like a mix of `#only` and `#uncover` with some reserving of
space.

By default, all elements that enter an `#alternatives` command are aligned at
the bottom left corner.
This might not always be the desired or most pleasant way to position it, so you
can provide an optional `position` argument to `#alternatives` that takes an
[`alignment` or `2d alignment`](https://typst.app/docs/reference/layout/align/#parameters--alignment).
For example:
```typ
We know that
#alternatives(position: center + horizon)[$pi$][$sqrt(2)^2 + 1/3$]
is
#alternative[irrational][rational].
```
makes the mathematical terms look better positioned.

Similar to `#one-by-one` and `#line-by-line`, `#alternatives` also has an optional
`start` argument that works just the same as for the other two.


## Cover mode
Covered content (using `#uncover`, `#one-by-one`, `#line-by-line`, or `pause`)
is completely invisible, by default.
You can decide to make it visible but less prominent using the optional `mode`
argument to each of those functions.
The `mode` argument takes two different values: `"invisible"` (the default) and
`"transparent"`.
(This terminology is taken from LaTeX beamer as well.)
With `mode: "transparent"`, text is printed in a light gray.

Use it as follows:
```typ
#uncover("3-5", mode: "transparent")[...]
#one-by-one(start: 2, mode: "transparent")[...][...]
#line-by-line(mode: "transparent")[
  ...
  ...
]
#show: pause(4, mode: "transparent")
```

**Warning!**
The transparent mode really only wraps the covered content in a
```typ
#text(fill: gray.lighten(50%)[...]
```
so it has only limited control over the actual display.
Especially
- text that defines its own color (e.g. syntax highlighting),
- visualisations,
- images

will not be affected by that.
This make the transparent mode only somewhat useful today.

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

## Handout mode
If you to distribute your slides after your talk for further reference, you might
not want to keep in all the dynamic content.
Imagine using `one-by-one` on a bullet point list and readers having to scroll
through endless pages when they just want to see the full list.

You can use `handout: true` in your slides' configuration to achieve this:
```typ
#show: slides.with(
  // ...
  handout: true
)
```

It has the effect that all dynamic visibility of elements _that reserve space_
is switched off.
So
```typ
Some text. #uncover("3-")[you cannot always see this] ...or can you?
```
behaves as
```typ
Some text. you cannot always see this ...or can you?
```
in handout mode, for example.

Note that `only` and `alternatives` are **not** affected as there is no obvious
way to unify their content to one slide.
