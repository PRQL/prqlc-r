test_that("simple examples", {
  expect_identical(
    "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
      prql_to_sql(),
    "SELECT\n  cyl,\n  mpg\nFROM\n  mtcars\nWHERE\n  cyl > 6"
  )
  expect_identical(
    "from mtcars \n filter cyl > 6 \n select [cyl, mpg]" |>
      prql_to_sql(),
    "SELECT\n  cyl,\n  mpg\nFROM\n  mtcars\nWHERE\n  cyl > 6"
  )
  expect_identical(
    "from mtcars
    filter cyl > 6
    select [cyl, mpg]" |>
      prql_to_sql(),
    "SELECT\n  cyl,\n  mpg\nFROM\n  mtcars\nWHERE\n  cyl > 6"
  )
})

test_that("Not a string object", {
  expect_error(
    1 |> prql_to_sql(),
    "Not a string object"
  )
  expect_error(
    c("a", "a") |> prql_to_sql(),
    "Not a string object"
  )
})
