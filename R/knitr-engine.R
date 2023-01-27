#' @title PRQL knitr engine
#' @description
#' If options$connection is NULL, the output is SQL query.
#' If options$connection is not NULL, the knitr's SQL engine is executed and the results are returned.
#' @return A character string.
#' @noRd
eng_prql <- function(options) {
  prql_code <- options$code |>
    paste0(collapse = "\n")

  dialect <- .get_engine_opts(options, "dialect")
  signature_comment <- .get_engine_opts(options, "signature_comment", TRUE)

  sql_code <- prql_code |>
    prql_compile(dialect = dialect, signature_comment = signature_comment)

  # elm coincidentally provides the best syntax highlight for prql.
  options$engine <- "elm"

  # Prints a SQL code block if there is no connection
  if (is.null(options$connection)) {
    options$comment <- ""
    options$results <- "asis"
    sql_code <- paste0(
      "```sql\n",
      sql_code,
      "\n```\n"
    )
    return(knitr::engine_output(options, prql_code, sql_code))
  }

  options$code <- sql_code

  knitr::knit_engines$get("sql")(options) |>
    sub(sql_code, prql_code, x = _, fixed = TRUE)
}

#' Get knitr engine options value or default value
#' @param options a list, knitr options.
#' @param opts_name the name of target engine option.
#' @param default the default value of the engine option.
#' @noRd
.get_engine_opts <- function(options, opts_name, default = NULL) {
  options$`engine-opts`[[opts_name]] %||% options$engine.opts[[opts_name]] %||% default
}
