# Utility features

Let us have a look at some common use cases you run into as either a theme
author or as an end user producing slides and what solutions are provided by
Polylux.

Specifically, the functions discussed here reside in the `utils`  and `logic`
modules.
They are exported by Polylux so if you (as someone making slides) imported it
using
```typ
{{#include ../IMPORT.typ}}
```
you can directly invoke them using `utils` and `logic`.
As a theme author, you have access to them due to the imports
```typ
#import "../logic.typ"
#import "../utils/utils.typ"
```
(see previous page).

