test_that("Set prql knitr engine", {
  expect_true("prql" %in% names(knitr::knit_engines$get()))
})

.knit_file <- function(file_name) {
  file <- file.path("files", file_name)
  output <- tempfile(fileext = "md")
  on.exit(unlink(output))

  suppressWarnings(knitr::knit(file, output, quiet = TRUE, envir = new.env()))

  readLines(output) |>
    paste0(collapse = "\n") |>
    cat()
}

patrick::with_parameters_test_that("Snapshot test of knitr-engine",
  {
    expect_snapshot(.knit_file(file_name), cran = TRUE)
  },
  file_name = c("r-style-opts.Rmd", "yaml-style-opts.Rmd")
)
