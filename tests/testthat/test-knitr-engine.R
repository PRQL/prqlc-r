test_that("Snapshot test of knitr-engine", {
  input <- file.path("files", "test-engine.Rmd")
  output <- tempfile(fileext = "md")

  knitr::knit(input, output)

  expect_snapshot(
    readLines(output) |>
      paste0(collapse = "\n") |>
      cat()
  )
})
