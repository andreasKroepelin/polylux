# Higher level helper functions
With `#only` and `#uncover` you can come a long way but there are some reoccurring
situations for which helper functions are provided.
We call them "higher level" because they use `#only` and `#uncover` under the
hood and operate on larger pieces of content.

For the common case of succesively revealing content, there are `#pause` and
`#one-by-one` and its friends.
For substituting content, we have `#alternatives` in different variants.
The following sections will describe these functions in detail.

