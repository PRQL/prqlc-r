#' @inherit compile
#' @param prql_qyery,prql a PRQL query string.
#' @param dialect a SQL dialect name to use. If not specified, the dialect contained in the query will be used.
#' @details [prql_to_sql] is deprecated in favor of [prql_compile].
#' @seealso available_dialects
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
#'   prql_compile("duckdb") |>
#'   cat()
#' @export
prql_compile <- function(prql_query, dialect = NA, format = TRUE, signature_comment = TRUE) {
  if (length(dialect) == 1 && !(dialect %in% c(NA, dialects))) {
    stop("Unsupported dialect. Please check with the 'available_dialects()' function for available dialects.")
  }
  compile(prql_query, dialect, format, signature_comment)
}

dialects <- c(
  "ansi",
  "bigquery",
  "clickhouse",
  "generic",
  "hive",
  "mssql",
  "mysql",
  "postgres",
  "sqlite",
  "snowflake",
  "duckdb"
)

#' @title Available dialect names
#' @return a character vector of dialect names.
available_dialects <- function() {
  dialects
}

#' @rdname compile
#' @export
prql_to_sql <- function(prql) {
  .Deprecated("prql_compile")
  prql_compile(prql)
}
