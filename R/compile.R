#' @title Compile a PRQL query into a SQL query
#' @param prql_query A character of PRQL query.
#' @param target A character of the target name to use or `NULL`.
#' If `NULL`, the target contained in the query will be used.
#' All available target names can be listed with the [prql_get_targets()] function.
#' @param ... Ignored.
#' @param format A logical flag (default: `TRUE`). Whether to format the SQL query.
#' @param signature_comment a logical flag. (default: `TRUE`).
#' Whether to add a signature comment to the output SQL query.
#' @param display A character, one of `"plain"` (default) or `"ansi_color"`.
#' If `"ansi_color"`, error will be displayed with ANSI color.
#' @return A character of the compiled SQL query.
#' @examples
#' "from mtcars | filter cyl > 6 | select {cyl, mpg}" |>
#'   prql_compile()
#'
#' "from mtcars | filter cyl > 6 | select {cyl, mpg}" |>
#'   prql_compile(format = FALSE, signature_comment = FALSE)
#'
#' "
#' from mtcars
#' filter cyl > 6
#' select !{cyl}
#' " |>
#'   prql_compile("sql.duckdb") |>
#'   cat()
#'
#' # If the `target` argument is `NULL` (default) or `"sql.any"`,
#' # the target specified in the header of the query will be used.
#' "
#' prql target:sql.duckdb
#'
#' from mtcars
#' filter cyl > 6
#' select !{cyl}
#' " |>
#'   prql_compile() |>
#'   cat()
#' @export
prql_compile <- function(
    prql_query,
    target = getOption("prqlr.target", default = NULL),
    ...,
    format = getOption("prqlr.format", default = TRUE),
    signature_comment = getOption("prqlr.signature_comment", default = TRUE),
    display = getOption("prqlr.display", default = "plain")) {
  compile(
    prql_query,
    target = target %||% "sql.any",
    format = format,
    signature_comment = signature_comment,
    display = display
  )
}

#' @title prqlc's version
#' @return a [numeric_version] with the version of the built-in prqlc.
#' @examples
#' prql_version()
#' @export
prql_version <- function() {
  numeric_version(compiler_version())
}
