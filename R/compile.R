#' @title Compile a PRQL query into a SQL query
#' @param prql_query a PRQL query string.
#' @param target a compile target name to use. If not specified, the target contained in the query will be used.
#' @param format a logical flag. Whether to format the SQL query.
#' @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
#' @return a SQL query string
#' @seealso [prql_get_targets]
#' @examples
#' "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
#'   prql_compile()
#'
#' "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
#'   prql_compile(format = FALSE, signature_comment = FALSE)
#'
#' "
#' from mtcars
#' filter cyl > 6
#' select ![cyl]
#' " |>
#'   prql_compile("sql.duckdb") |>
#'   cat()
#'
#' # If the `target` argument is `NULL` (default) or `NA` or `"sql.any"`,
#' # the target specified in the header of the query will be used.
#' "
#' prql target:sql.duckdb
#'
#' from mtcars
#' filter cyl > 6
#' select ![cyl]
#' " |>
#'   prql_compile() |>
#'   cat()
#' @export
prql_compile <- function(
    prql_query,
    target = getOption("prqlr.target", default = NULL),
    format = getOption("prqlr.format", default = TRUE),
    signature_comment = getOption("prqlr.signature_comment", default = TRUE)) {
  if (length(target) == 1 && !(target %in% c(NA, prql_get_targets()))) {
    paste0(
      r"(Unsupported target `")",
      target,
      r"("`. Please check with the `prql_get_targets()` function for available targets.)"
    ) |>
      stop()
  }

  compile(prql_query, target, format, signature_comment) |>
    unwrap()
}

#' @title prql-compiler's version
#' @return a [numeric_version] with the version of the built-in prql-compiler.
#' @examples
#' prql_version()
#' @export
prql_version <- function() {
  numeric_version(compiler_version())
}
