test_that("Not a string object", {
  expect_error(
    1 |> prql_compile(),
    "Expected Strings got Doubles"
  )
  expect_error(
    c("a", "a") |> prql_compile(),
    "Expected Scalar, got Strings"
  )
})

test_that("Unsupported dialect", {
  expect_error(
    prql_compile("from a | select [b]", "foo"),
    r"(Please check with the 'prql_available_dialects\(\)' function)"
  )
})

test_that("PRQL query", {
  expect_snapshot(cat(prql_compile("from a | select [b]")))
  expect_snapshot(cat(prql_compile("from a | select [b]"), NA, FALSE, FALSE))
  expect_snapshot(
    "from star_wars
    select [star_wars.*]
    select ![jar_jar_binks, midichlorians]"
    |>
      compile("duckdb", TRUE, TRUE) |>
      cat()
  )
})
