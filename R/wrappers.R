#' @useDynLib prqlr, .registration = TRUE
#' @keywords internal
NULL

#' @title Compile a PRQL query into a SQL query
#' @param prql_query a PRQL query string.
#' @param target a compile target name to use.
#' @param format a logical flag. Whether to format the SQL query.
#' @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
#' @return a list contains a SQL string or an error message.
#' @noRd
compile <- function(prql_query, target, format, signature_comment) {
  .Call(compile__impl, prql_query, target, format, signature_comment)
}

#' @noRd
prql_to_pl <- function(prql_query) {
  .Call(prql_to_pl__impl, prql_query)
}

#' @noRd
pl_to_rq <- function(pl_json) {
  .Call(pl_to_rq__impl, pl_json)
}

#' @noRd
rq_to_sql <- function(rq_json) {
  .Call(rq_to_sql__impl, rq_json)
}

#' @title prqlc's version
#' @return a prqlc's version string
#' @noRd
compiler_version <- function() {
  .Call(compiler_version__impl)
}

#' @title Get available target names
#' @description Get available target names for the `target` option of the [prql_compile()] function.
#' @return a character vector of target names.
#' @examples
#' prql_get_targets()
#' @export
prql_get_targets <- function() {
  .Call(prql_get_targets__impl)
}


