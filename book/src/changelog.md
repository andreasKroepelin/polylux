# Changelog

## 0.4.0

After what must have felt like ages for everyone, we finally have a new release
of Polylux! 🥳

Version 0.4.0 is now fit for Typst 0.12.0 and has become more streamlined.
From now on, we rely on the Typst support for templates and the package does not
ship builtin themes anymore.
In the meantime, other packages for building slides in Typst have gained
traction and it is a natural question why you should still use Polylux.
Well, that I don't know.
But _I_ still use Polylux because I like a "non hacky" way of using Typst.
Polylux has now taken on the policy that features are preferrably not
implemented rather than implemented in hacky way, potentially relying on brittle
internals of Typst and such.
There is of course no rigorous definition for that so in the end it comes down
to what I consider acceptable for myself.
At the same time, I hope that other might share this view and can enjoy this new
version of Polylux.

Some notable changes, besides the removal of themes:
- The dreaded `#pause` was removed in favour of `#show: later`.
- There is a new `toolbox` module exported by Polylux that contains many helpful
  elements for designing your own slides (some of them have previously been
  available in the now removed `utils` module).
- The book has been improved both in content and visuals.
- By changing the internal infrastructure for creating example previews,
  Polylux is finally considered a Typst repo by GitHub :D
- The Polylux repository now resides in a custom polylux-typ GitHub
  organisation.
- Polylux has a new logo.
  It's more elegant than the previous one although I know that some liked the
  silliness of the googly eyes...

I recommend going through the book and finding out how Polylux works now!
 
## v0.3.0

- The previously existing module `helpers` was transformed to `utils` and now
  contains many more useful features.
- The modules `logic` and `utils` are now directly accessible when importing
  Polylux (it was a bug that it did not work previously).
- We finally have an ergonomic `#pause` function that does not expect the user
  to keep track of some counter themselves.
- The `#alternatives` function has gained lots of friends that make specific
  situations a bit more convenient, namely `#alternatives-match`,
  `alternatives-cases`, and `alternatives-fn`.
  Also, there is a parameter `repeat-last` for `#alternatives` now.
- Bullet lists, enumerations, and term lists now have custom functions to display
  them dynamically: `#list-one-by-one`, `#enum-one-by-one`, and `#terms-one-by-one`.
- There is a new function `#fit-to-height` that allows you to resize content to
  a given height (especially make it fill the remaining space on a slide!)
  Thank you to [@ntjess](https://github.com/ntjess) for the initial implementation!
- Previously, certain themes allowed you to easily put multiple content elements
  next to each other.
  This is now a commonly available function: `#side-by-side`.
  You can use it regardless of any theme and the functionality was removed from
  the previously implementing themes.
- Polylux now has special support for the pdfpc presentation viewer.
  You can add speaker notes, hide slides, configure the timer, and more all from
  within your Typst source file.
  Thank you to [@JuliusFreudenberger](https://github.com/JuliusFreudenberger)
  for the inspiration and for creating the `polylux2pdfpc` AUR package.
