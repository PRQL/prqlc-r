% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compile.R
\name{prql_compile}
\alias{prql_compile}
\title{Compile a PRQL query into a SQL query}
\usage{
prql_compile(
  prql_query,
  target = getOption("prqlr.target", default = NULL),
  ...,
  format = getOption("prqlr.format", default = TRUE),
  signature_comment = getOption("prqlr.signature_comment", default = TRUE),
  display = getOption("prqlr.display", default = "plain")
)
}
\arguments{
\item{prql_query}{A character of PRQL query.}

\item{target}{A character of the target name to use or \code{NULL}.
If \code{NULL}, the target contained in the query will be used.
All available target names can be listed with the \code{\link[=prql_get_targets]{prql_get_targets()}} function.}

\item{...}{Ignored.}

\item{format}{A logical flag (default: \code{TRUE}). Whether to format the SQL query.}

\item{signature_comment}{a logical flag. (default: \code{TRUE}).
Whether to add a signature comment to the output SQL query.}

\item{display}{A character, one of \code{"plain"} (default) or \code{"ansi_color"}.
If \code{"ansi_color"}, error will be displayed with ANSI color.}
}
\value{
A character of the compiled SQL query.
}
\description{
Compile a PRQL query into a SQL query
}
\examples{
"from mtcars | filter cyl > 6 | select {cyl, mpg}" |>
  prql_compile()

"from mtcars | filter cyl > 6 | select {cyl, mpg}" |>
  prql_compile(format = FALSE, signature_comment = FALSE)

"
from mtcars
filter cyl > 6
select !{cyl}
" |>
  prql_compile("sql.duckdb") |>
  cat()

# If the `target` argument is `NULL` (default) or `"sql.any"`,
# the target specified in the header of the query will be used.
"
prql target:sql.duckdb

from mtcars
filter cyl > 6
select !{cyl}
" |>
  prql_compile() |>
  cat()
}
