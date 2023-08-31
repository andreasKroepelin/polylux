# Changelog

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
