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

test_that("Unsupported target", {
  expect_error(
    prql_compile("from a | select [b]", "foo"),
    r"(Please check with the 'prql_available_targets\(\)' function)"
  )
})

test_that("Options", {
  withr::local_options(list(prqlr.target = "sql.mssql", prqlr.format = FALSE, prqlr.signature_comment = FALSE))
  expect_equal(prql_compile("from a | take 1"), "SELECT TOP (1) * FROM a")
  withr::local_options(list(prqlr.target = "sql.postgres", prqlr.format = FALSE, prqlr.signature_comment = FALSE))
  expect_equal(prql_compile("from a | take 1"), "SELECT * FROM a LIMIT 1")
})

test_that("PRQL query", {
  expect_snapshot(cat(prql_compile("from a | select [b]")))
  expect_snapshot(cat(prql_compile("from a | select [b]", NA, FALSE, FALSE)))
  expect_snapshot(
    "from star_wars
    select [star_wars.*]
    select ![jar_jar_binks, midichlorians]"
    |>
      compile("duckdb", TRUE, TRUE) |>
      unwrap() |>
      cat()
  )
})

patrick::with_parameters_test_that("Targets",
  {
    query <- "
from flights
filter (distance | in 200..300)
filter air_time != null
group [origin, dest] (
  aggregate [
    num_flts = count,
    avg_delay = (average arr_delay | round 0)
  ]
)
sort [-origin, avg_delay]
take 2
"
    expect_snapshot(cat(prql_compile(query, target, TRUE, FALSE)))
  },
  target = prql_available_targets()
)

test_that("prql-compiler's version", {
  expect_equal(prql_version(), numeric_version("0.4.2"))
})
