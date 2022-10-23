
# prqlr

<!-- badges: start -->
<!-- badges: end -->

R bindings for [the `prql-compiler` Rust library](https://crates.io/crates/prql-compiler).

## Installation

TBD

## Example

```r
library(prqlr)
"from mtcars \n filter cyl > 6 \n select [cyl, mpg]" |> prql_to_sql()
#> [1] "SELECT\n  cyl,\n  mpg\nFROM\n  mtcars\nWHERE\n  cyl > 6"
```
