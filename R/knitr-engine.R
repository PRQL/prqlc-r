#' @title PRQL knitr engine
#' @description
#' If options$connection is NULL, the output is SQL query.
#' If options$connection is not NULL, the knitr's SQL engine is executed and the results are returned.
#' @return A character string.
#' @noRd
eng_prql <- function(options) {
  prql_code <- options$code |>
    paste0(collapse = "\n")

  # elm coincidentally provides the best syntax highlight for prql.
  options$lang <- options$lang %||% "elm"

  # Workaround for Quarto CLI 1.3
  # https://github.com/quarto-dev/quarto-cli/pull/4735
  options$engine <- "elm"

  if (isFALSE(options$eval)) {
    return(knitr::engine_output(options, prql_code, ""))
  }

  if (options$engine.opts[["use_glue"]] %||% FALSE) {
    prql_code <- glue::glue(prql_code, .open = "{{", .close = "}}", .envir = knitr::knit_global())
  }

  sql_code <- prql_code |>
    prql_compile(
      target = options$engine.opts[["target"]] %||% getOption("prqlr.target"),
      format = TRUE,
      signature_comment = options$engine.opts[["signature_comment"]] %||% getOption("prqlr.signature_comment", TRUE)
    )

  # Prints a SQL code block if there is no connection
  if (is.null(options$connection)) {
    options$comment <- ""
    options$results <- "asis"
    info_string <- options$engine.opts[["info_string"]] %||% "sql"

    out <- paste0(
      "```", info_string, "\n",
      sql_code,
      "```\n"
    )

    return(knitr::engine_output(options, prql_code, out))
  }

  options$code <- sql_code

  knitr::knit_engines$get("sql")(options) |>
    sub(sql_code, prql_code, x = _, fixed = TRUE)
}
