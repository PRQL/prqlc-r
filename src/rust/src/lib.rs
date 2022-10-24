use extendr_api::prelude::*;

/// @title Compile a PRQL string into a SQL string
/// @param prql A PRQL string
/// @return A SQL string
/// @examples
/// "from mtcars | filter cyl > 6 | select [cyl, mpg]" |>
///   prql_to_sql()
/// @export
#[extendr]
fn prql_to_sql(prql: &str) -> String {
    match prql_compiler::compile(prql) {
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
}