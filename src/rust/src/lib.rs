use extendr_api::prelude::*;

/// @title Compile a PRQL string into a SQL string
/// @param prql A PRQL string
/// @return A SQL string
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_sql()
///
/// # Show the SQL string with the cli package's cli_code function
/// if (requireNamespace("cli", quietly = TRUE)) {
///   library(cli)
///   "
///   from mtcars
///   filter cyl > 6
///   select [cyl, mpg]
///   " |>
///     prql_to_sql() |>
///     cli_code(language = "sql")
/// }
/// @export
#[extendr]
fn prql_to_sql(prql: &str) -> String {
    let result = prql_compiler::compile(prql);
    unwrap_or_throw(result)
}

/// @title Format a PRQL string
/// @param prql A PRQL string
/// @return A PRQL string
/// @examples
/// format_prql("from mtcars | select cyl")
///
/// # Show the PQL string with the cli package's cli_code function
/// if (requireNamespace("cli", quietly = TRUE)) {
///   library(cli)
///   "
///   from mtcars
///   filter cyl > 6
///   select [cyl, mpg]
///   " |>
///     format_prql() |>
///     cli_code(language = "elm")
///     # Coincidentally, elm's syntax highlighting is best suited for prql
/// }
/// @export
#[extendr]
fn format_prql(prql: &str) -> String {
    let result = prql_compiler::format(prql);
    unwrap_or_throw(result)
}

/// @title Compile a PRQL string into a JSON version of the Query
/// @param prql A PRQL string
/// @return A JSON string of AST
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_json()
/// @seealso [json_to_prql()]
/// @export
#[extendr]
fn prql_to_json(prql: &str) -> String {
    let result = prql_compiler::to_json(prql);
    unwrap_or_throw(result)
}

/// @title Convert a JSON AST back to a PRQL string
/// @param json A JSON string of AST
/// @return A PRQL string
/// @seealso [prql_to_json()]
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_json() |>
///   json_to_prql()
/// @export
#[extendr]
fn json_to_prql(json: &str) -> String {
    let result = prql_compiler::from_json(json);
    unwrap_or_throw(result)
}

fn unwrap_or_throw(result: anyhow::Result<String>) -> String {
    match result {
        Ok(v) => v,
        Err(e) => {
            throw_r_error(e.to_string());
            unreachable!()
        }
    }
}

extendr_module! {
    mod prqlr;
    fn prql_to_sql;
    fn format_prql;
    fn prql_to_json;
    fn json_to_prql;
}
