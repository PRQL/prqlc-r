use extendr_api::prelude::*;
use std::str::FromStr;

/// @title Compile a PRQL query into a SQL query
/// @param prql_query a PRQL query string.
/// @param dialect a SQL dialect name to use. If it is not a valid value, the dialect contained in the query will be used.
/// @param format a logical flag. Whether to format the SQL query.
/// @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
/// @return a SQL query string
/// @noRd
#[extendr(use_try_from = true)]
pub fn compile(
    prql_query: &str,
    dialect: Option<String>,
    format: bool,
    signature_comment: bool,
) -> String {
    let dialect = prql_compiler::sql::Dialect::from_str(dialect.as_deref().unwrap_or_default())
        .map(From::from)
        .ok();

    let options: Option<prql_compiler::sql::Options> = Some(prql_compiler::sql::Options {
        format,
        dialect,
        signature_comment,
    });

    let result = Ok(prql_query)
        .and_then(prql_compiler::prql_to_pl)
        .and_then(prql_compiler::pl_to_rq)
        .and_then(|rq| prql_compiler::rq_to_sql(rq, options.map(prql_compiler::sql::Options::from)))
        .map_err(|e| e.composed("", prql_query, false));

    unwrap_or_throw(result)
}

/// @noRd
#[extendr]
pub fn prql_to_pl(prql_query: &str) -> String {
    let result = Ok(prql_query)
        .and_then(prql_compiler::prql_to_pl)
        .and_then(prql_compiler::json::from_pl);

    unwrap_or_throw(result)
}

/// @noRd
#[extendr]
pub fn pl_to_rq(pl_json: &str) -> String {
    let result = Ok(pl_json)
        .and_then(prql_compiler::json::to_pl)
        .and_then(prql_compiler::pl_to_rq)
        .and_then(prql_compiler::json::from_rq);

    unwrap_or_throw(result)
}

/// @noRd
#[extendr]
pub fn rq_to_sql(rq_json: &str) -> String {
    let result = Ok(rq_json)
        .and_then(prql_compiler::json::to_rq)
        .and_then(|x| prql_compiler::rq_to_sql(x, None));

    unwrap_or_throw(result)
}

fn unwrap_or_throw(result: anyhow::Result<String, prql_compiler::ErrorMessages>) -> String {
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
    fn compile;
    fn prql_to_pl;
    fn pl_to_rq;
    fn rq_to_sql;
}
