test_that("target set in the header ", {
  mssql_query <- "prql target:sql.mssql\nfrom a | take 1"

  expect_equal(
    prql_compile(mssql_query, format = FALSE, signature_comment = FALSE),
    "SELECT * FROM a ORDER BY (SELECT NULL) OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY"
  )
  expect_equal(
    prql_compile(mssql_query, target = "sql.any", format = FALSE, signature_comment = FALSE),
    "SELECT * FROM a ORDER BY (SELECT NULL) OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY"
  )
  expect_equal(
    prql_compile(mssql_query, target = "sql.generic", format = FALSE, signature_comment = FALSE),
    "SELECT * FROM a LIMIT 1"
  )
})

test_that("Not a string object", {
  expect_error(
    1 |> prql_compile(),
    "Unexpected type"
  )
  expect_error(
    c("a", "a") |> prql_compile(),
    "Must be length 1 of non-missing value"
  )
})

test_that("Unsupported target", {
  expect_error(
    prql_compile("from a | select {b}", "foo"),
    r"(target `"foo"` not found)"
  )
  expect_error(
    prql_compile("from a | select {b}", NA),
    "Unexpected type"
  )
  expect_error(
    prql_compile("from a | select {b}", NA_character_),
    "non-missing value"
  )
  expect_error(
    prql_compile("prql target:foo\nfrom a | select {b}"),
    r"(target `"foo"` not found)"
  )
  expect_error(
    prql_compile("prql target:sql.foo\nfrom a | select {b}"),
    r"(target `"sql.foo"` not found)"
  )
})

test_that("Options", {
  withr::local_options(list(prqlr.target = "sql.mssql", prqlr.format = FALSE, prqlr.signature_comment = FALSE))
  expect_equal(prql_compile("from a | take 1"), "SELECT * FROM a ORDER BY (SELECT NULL) OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY")
  withr::local_options(list(prqlr.target = "sql.postgres", prqlr.format = FALSE, prqlr.signature_comment = FALSE))
  expect_equal(prql_compile("from a | take 1"), "SELECT * FROM a LIMIT 1")
})

test_that("PRQL query", {
  expect_snapshot(cat(prql_compile("from a | select {b}")))
  expect_snapshot(cat(prql_compile("from a | select {b}", NULL, FALSE, FALSE)))
  expect_snapshot(
    "from star_wars
    select {star_wars.*}
    select !{jar_jar_binks, midichlorians}"
    |>
      compile("sql.duckdb", TRUE, TRUE) |>
      cat()
  )
})

patrick::with_parameters_test_that("Syntax error",
  {
    expect_snapshot(cat(prql_compile(query, "sql.any", TRUE, FALSE)), error = TRUE)
  },
  query = c("Mississippi has four S’s and four I’s.", "from a | select [b]", "from a | select {{{b")
)

patrick::with_parameters_test_that("Targets",
  {
    query <- "
from flights
filter (distance | in 200..300)
filter air_time != null
group {origin, dest} (
  aggregate {
    num_flts = count this,
    avg_delay = (average arr_delay | math.round 0)
  }
)
sort {-origin, avg_delay}
take 2
"
    expect_snapshot(cat(prql_compile(query, target, TRUE, FALSE)))
  },
  target = prql_get_targets()
)

test_that("prqlc's version", {
  expect_snapshot(prql_version())
  expect_s3_class(prql_version(), "numeric_version")
})
