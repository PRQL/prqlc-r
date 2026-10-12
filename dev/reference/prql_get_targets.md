# Get available target names

Get available target names for the `target` option of the
[`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
function.

## Usage

``` r
prql_get_targets()
```

## Value

a character vector of target names.

## Examples

``` r
prql_get_targets()
#>  [1] "sql.any"        "sql.ansi"       "sql.bigquery"   "sql.clickhouse"
#>  [5] "sql.duckdb"     "sql.generic"    "sql.glaredb"    "sql.mssql"     
#>  [9] "sql.mysql"      "sql.postgres"   "sql.sqlite"     "sql.snowflake" 
```
