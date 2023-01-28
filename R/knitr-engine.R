#' @title PRQL knitr engine
#' @description
#' If options$connection is NULL, the output is SQL query.
#' If options$connection is not NULL, the knitr's SQL engine is executed and the results are returned.
#' @return A character string.
#' @noRd
eng_prql <- function(options) {
  prql_code <- options$code |>
    paste0(collapse = "\n")

  compile_options <- c(
    options$`engine-opts`[names(options$`engine-opts`) %in% names(formals(prql_compile))],
    options$engine.opts[names(options$`engine-opts`) %in% names(formals(prql_compile))]
  )

  sql_code <- do.call(prql_compile, c(list(prql_code), compile_options))

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
