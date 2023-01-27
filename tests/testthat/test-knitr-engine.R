test_that("Set prql knitr engine", {
  expect_true("prql" %in% names(knitr::knit_engines$get()))
})

test_that("Snapshot test of knitr-engine", {
  input <- file.path("files", "example1.Rmd")
  output <- tempfile(fileext = "md")
  on.exit(unlink(output))

  suppressWarnings(knitr::knit(input, output, quiet = TRUE, envir = new.env()))

  expect_snapshot(
    readLines(output) |>
      paste0(collapse = "\n") |>
      cat()
  )
})
