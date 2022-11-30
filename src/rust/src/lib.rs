use extendr_api::prelude::*;

/// @title Compile a PRQL string into a SQL string
/// @param prql A PRQL string
/// @return A SQL string
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_sql()
///
/// "
/// from mtcars
/// filter cyl > 6
/// select [cyl, mpg]
/// " |>
///   prql_to_sql() |>
///   cat()
/// @export
#[extendr]
fn prql_to_sql(prql: &str) -> String {
    let result = prql_compiler::compile(prql);
    unwrap_or_throw(result)
}

/// @title Compile a PRQL string into a JSON version of the Query
/// @param prql A PRQL string
/// @return A JSON string of AST
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_json() |>
///   cat()
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
///   json_to_prql() |>
///   cat()
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
    fn prql_to_json;
    fn json_to_prql;
}
