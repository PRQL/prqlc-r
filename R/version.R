#' @title prql-compiler's version
#' @return a [numeric_version] with the version of the built-in prql-compiler.
#' @examples
#' prql_version()
#' @export
prql_version <- function() {
  numeric_version(compiler_version())
}
