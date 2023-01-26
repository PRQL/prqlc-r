test_that("prql-compiler's version", {
  expect_equal(prql_version(), numeric_version("0.4.2"))
})
