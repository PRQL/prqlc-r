use extendr_api::prelude::*;
use std::str::FromStr;

pub mod utils;
use crate::utils::r_result_list;

/// @title Compile a PRQL query into a SQL query
/// @param prql_query a PRQL query string.
/// @param target a compile target name to use. If it is not a valid value, the target contained in the query will be used.
/// @param format a logical flag. Whether to format the SQL query.
/// @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
/// @return a list contains a SQL string or an error message.
/// @noRd
#[extendr(use_try_from = true)]
pub fn compile(
    prql_query: &str,
    target: Option<String>,
    format: bool,
    signature_comment: bool,
) -> List {
    let target = prql_compiler::Target::from_str(&target.unwrap_or_default()).unwrap_or_default();

    let options: prql_compiler::Options = prql_compiler::Options {
        format,
        target,
        signature_comment,
    };

    let result = Ok(prql_query)
        .and_then(prql_compiler::prql_to_pl)
        .and_then(prql_compiler::pl_to_rq)
        .and_then(|rq| prql_compiler::rq_to_sql(rq, options))
        .map_err(|e| e.composed("", prql_query, false));

    r_result_list(result)
}

/// @noRd
#[extendr]
pub fn prql_to_pl(prql_query: &str) -> List {
    let result = Ok(prql_query)
        .and_then(prql_compiler::prql_to_pl)
        .and_then(prql_compiler::json::from_pl);

    r_result_list(result)
}

/// @noRd
#[extendr]
pub fn pl_to_rq(pl_json: &str) -> List {
    let result = Ok(pl_json)
        .and_then(prql_compiler::json::to_pl)
        .and_then(prql_compiler::pl_to_rq)
        .and_then(prql_compiler::json::from_rq);

    r_result_list(result)
}

/// @noRd
#[extendr]
pub fn rq_to_sql(rq_json: &str) -> List {
    let result = Ok(rq_json)
        .and_then(prql_compiler::json::to_rq)
        .and_then(|x| prql_compiler::rq_to_sql(x, prql_compiler::Options::default()));

    r_result_list(result)
}

/// @title prql-compiler's version
/// @return a prql-compiler's version string
/// @noRd
#[extendr]
pub fn compiler_version() -> String {
    prql_compiler::PRQL_VERSION.to_string()
}

/// @title Get available target names
/// @description Get available target names for the `target` option of the [prql_compile()] function.
/// @return a character vector of target names.
/// @examples
/// prql_get_targets()
/// @export
#[extendr]
pub fn prql_get_targets() -> Vec<String> {
    prql_compiler::Target::names()
}

extendr_module! {
    mod prqlr;
    fn compile;
    fn prql_to_pl;
    fn pl_to_rq;
    fn rq_to_sql;
    fn compiler_version;
    fn prql_get_targets;
}
