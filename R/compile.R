#' @title Compile a PRQL query into a SQL query
#' @param prql_query,prql a PRQL query string.
#' @param dialect a SQL dialect name to use. If not specified, the dialect contained in the query will be used.
#' @param format a logical flag. Whether to format the SQL query.
#' @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
#' @return a SQL query string
#' @details [prql_to_sql] is deprecated in favor of [prql_compile].
#' @seealso [prql_available_dialects]
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
#'
#' # Target dialect can also be written in the PRQL query.
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
prql_compile <- function(prql_query, dialect = NA, format = TRUE, signature_comment = TRUE) {
  if (length(dialect) == 1 && !(dialect %in% c(NA, dialects))) {
    stop("Unsupported dialect. Please check with the 'prql_available_dialects()' function for available dialects.")
  }

  compile(prql_query, dialect, format, signature_comment) |>
    unwrap()
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
#' @description Available dialects for the `dialect` option of the [prql_compile()] function.
#' @return a character vector of dialect names.
#' @examples
#' prql_available_dialects()
#' @export
prql_available_dialects <- function() {
  dialects
}

#' @rdname prql_compile
#' @export
prql_to_sql <- function(prql) {
  .Deprecated("prql_compile")

  prql_compile(prql)
}
