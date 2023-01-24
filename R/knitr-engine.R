#' @title PRQL knitr engine
#' @noRd
eng_prql <- function(options) {
  prql_code <- options$code |>
    paste0(collapse = "\n")
  sql_code <- prql_code |>
    prql_compile()

  options$code <- sql_code

  # elm coincidentally provides the best syntax highlight for prql.
  options$engine <- "elm"

  eng_sql <- utils::getFromNamespace("eng_sql", "knitr")
  eng_sql(options) |>
    sub(sql_code, prql_code, x = _, fixed = TRUE)
}
