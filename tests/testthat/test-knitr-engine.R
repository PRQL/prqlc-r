test_that("Set prql knitr engine", {
  expect_true("prql" %in% names(knitr::knit_engines$get()))
})

.knit_file <- function(file_name) {
  file <- file.path("files", file_name)
  output <- tempfile(fileext = "md")
  opts <- options(knitr.sql.html_div = FALSE)
  on.exit({
    unlink(output)
    options(opts)
  })

  suppressWarnings(knitr::knit(file, output, quiet = TRUE, envir = new.env()))

  readLines(output) |>
    paste0(collapse = "\n") |>
    cat()
}

test_that("Snapshot test of knitr-engine", {
  expect_snapshot(.knit_file("r-style-opts.Rmd"), cran = TRUE)
  expect_snapshot(.knit_file("yaml-style-opts.Rmd"), cran = TRUE)
  expect_snapshot(
    withr::with_options(
      list(prqlr.target = "sql.mssql", prqlr.format = FALSE, prqlr.signature_comment = FALSE),
      .knit_file("minimal.Rmd")
    ),
    cran = TRUE
  )
  expect_snapshot(.knit_file("glue.Rmd"), cran = TRUE)
  expect_snapshot(.knit_file("change-lang.Rmd"), cran = TRUE)
  expect_snapshot(.knit_file("info-string.Rmd"), cran = TRUE)
  expect_snapshot(.knit_file("eval-opt.Rmd"), cran = TRUE)
})
