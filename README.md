
# prqlr

<!-- badges: start -->
[![prqlr status badge](https://eitsupi.r-universe.dev/badges/prqlr)](https://eitsupi.r-universe.dev)
[![CRAN status](https://www.r-pkg.org/badges/version/prqlr)](https://CRAN.R-project.org/package=prqlr)
<!-- badges: end -->

R bindings for [the `prql-compiler` Rust library](https://crates.io/crates/prql-compiler/),
powered by [the `extendr` framework](https://extendr.github.io/).

## Installation

Requires R 4.2.0 or later.

This package can be installed from [R-universe](https://eitsupi.r-universe.dev/ui#package:prqlr).
If available, a binary package will be installed.

```r
install.packages("prqlr", repos = "https://eitsupi.r-universe.dev")
```

For source installation, the Rust toolchain must be configured.
Please check the <https://github.com/r-rust/hellorust> repository.

## Example

```r
library(prqlr)
"from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
  prql_to_sql() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
```

PRQL's pipelines can be joined by the newline character (`\n`), or actual newlines in addition to `|`.

```r
"from mtcars \n filter cyl > 6 \n select [cyl, mpg]" |>
  prql_to_sql() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
```

```r
"from mtcars
filter cyl > 6
select [cyl, mpg]" |>
  prql_to_sql() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
```

Thanks to the `{tidyquery}` package,
we can even convert a PRQL query to a SQL query and then to a `{dplyr}` query!

```r
"from mtcars
filter cyl > 6
select [cyl, mpg]" |>
  prql_to_sql() |>
  tidyquery::show_dplyr()
#> mtcars %>%
#>   filter(cyl > 6) %>%
#>   select(cyl, mpg)
```

## Development

Use the `rextendr::document()` function to generate R source code from Rust source code in the `src` directory.
