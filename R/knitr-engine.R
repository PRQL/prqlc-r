#' @title PRQL knitr engine
#' @description
#' If options$connection is NULL, the output is SQL query.
#' If options$connection is not NULL, the knitr's SQL engine is executed and the results are returned.
#' @return A character string.
#' @noRd
eng_prql <- function(options) {
  prql_code <- options$code |>
    paste0(collapse = "\n")

  target <- .get_engine_opt(options, "target", getOption("prqlr.target"))
  signature_comment <- .get_engine_opt(options, "signature_comment", getOption("prqlr.signature_comment", TRUE))

  sql_code <- prql_code |>
    prql_compile(target = target, format = TRUE, signature_comment = signature_comment)

  # elm coincidentally provides the best syntax highlight for prql.
  options$lang <- options$lang %||% "elm"

  # Prints a SQL code block if there is no connection
  if (is.null(options$connection)) {
    options$comment <- ""
    options$results <- "asis"
    sql_code <- paste0(
      "```sql\n",
      sql_code,
      "```\n"
    )
    return(knitr::engine_output(options, prql_code, sql_code))
  }

  options$code <- sql_code

  knitr::knit_engines$get("sql")(options) |>
    sub(sql_code, prql_code, x = _, fixed = TRUE)
}

#' Get knitr engine options value or default value
#' @param options a list, knitr options.
#' @param opt_name the name of target engine option.
#' @param default the default value of the engine option.
#' @noRd
.get_engine_opt <- function(options, opt_name, default = NULL) {
  options$`engine-opts`[[opt_name]] %||% options$engine.opts[[opt_name]] %||% default
}
