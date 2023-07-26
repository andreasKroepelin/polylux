# `#alternatives` to substitute content
The so far discussed helpers `#one-by-one`, `#line-by-line`, and `pause` all
build upon `#uncover`.
There is an analogon to `#one-by-one` that is based on `#only`, namely
`#alternatives`.
You can use it to show some content on one subslide, then substitute it by
something else, then by something else, etc.

Consider this example:
```typ
{{#include poor-alternatives.typ:6:11}}
```
Here, we want to display three different sentences with the same structure:
Some person likes some sort of ice cream.

![poor-alternatives](poor-alternatives.png)

As you can see, the positioning of `likes` and `ice cream` moves
around in the produced slide because, for example, `Ann` takes much less space
than `Christopher` when using `#only` for that job.
This somewhat disturbs the perception of the constant structure of the sentence
and that only the names and kinds of ice cream change.

To avoid such movement and only subsitute certain parts of content, you can use
the `#alternatives` function.
With it, our example becomes:
```typ
{{#include alternatives.typ:6:11}}
```
resulting in

![alternatives](alternatives.png)

`#alternatives` will put enough empty space around, for example, `Ann` such that
it uses the same amount of space as `Christopher`.
In a sense, it is like a mix of `#only` and `#uncover` with some reserving of
space.

By default, all elements that enter an `#alternatives` command are aligned at
the bottom left corner.
This might not always be the desired or the most pleasant way to position it, so
you can provide an optional `position` argument to `#alternatives` that takes an
[`alignment` or `2d alignment`](https://typst.app/docs/reference/layout/align/#parameters--alignment).
For example:
```typ
{{#include alternatives-position.typ:6:9}}
```
makes the mathematical terms look better positioned:

![alternatives-position](alternatives-position.png)

Similar to `#one-by-one` and `#line-by-line`, `#alternatives` also has an optional
`start` argument that works just the same as for the other two.

