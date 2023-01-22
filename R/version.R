#' @title prql-compiler's version
#' @return a [numeric_version] with the version of the prql-compiler.
#' @examples
#' prql_compiler_version()
#' @export
prql_compiler_version <- function() {
  numeric_version(compiler_version())
}
