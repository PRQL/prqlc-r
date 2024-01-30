use anstream::ColorChoice;
use savvy::{savvy, Sexp};
use std::str::FromStr;

/// @title Compile a PRQL query into a SQL query
/// @param prql_query a PRQL query string.
/// @param target a compile target name to use.
/// @param format a logical flag. Whether to format the SQL query.
/// @param signature_comment a logical flag. Whether to add a signature comment to the output SQL query.
/// @return a list contains a SQL string or an error message.
/// @noRd
#[savvy]
pub fn compile(
    prql_query: &str,
    target: &str,
    format: bool,
    signature_comment: bool,
) -> savvy::Result<Sexp> {
    let options = convert_options(CompileOptions {
        format,
        target: target.to_string(),
        signature_comment,
    });

    let result = options
        .and_then(|opts| {
            Ok(prql_query)
                .and_then(prql_compiler::prql_to_pl)
                .and_then(prql_compiler::pl_to_rq)
                .and_then(|rq| prql_compiler::rq_to_sql(rq, &opts))
        })
        .map_err(|e| e.composed(&prql_query.into()));

    ColorChoice::write_global(self::ColorChoice::Never);

    match result {
        Ok(msg) => msg.try_into(),
        Err(e) => Err(e.to_string().into()),
    }
}

struct CompileOptions {
    format: bool,
    target: String,
    signature_comment: bool,
}

fn convert_options(
    o: CompileOptions,
) -> core::result::Result<prql_compiler::Options, prql_compiler::ErrorMessages> {
    let target = prql_compiler::Target::from_str(&o.target)
        .map_err(|e| prql_compiler::downcast(e.into()))?;

    Ok(prql_compiler::Options {
        format: o.format,
        target,
        signature_comment: o.signature_comment,
        color: false,
    })
}

/// @noRd
#[savvy]
pub fn prql_to_pl(prql_query: &str) -> savvy::Result<Sexp> {
    let result = Ok(prql_query)
        .and_then(prql_compiler::prql_to_pl)
        .and_then(prql_compiler::json::from_pl);

    match result {
        Ok(msg) => msg.try_into(),
        Err(e) => Err(e.to_string().into()),
    }
}

/// @noRd
#[savvy]
pub fn pl_to_rq(pl_json: &str) -> savvy::Result<Sexp> {
    let result = Ok(pl_json)
        .and_then(prql_compiler::json::to_pl)
        .and_then(prql_compiler::pl_to_rq)
        .and_then(prql_compiler::json::from_rq);

    match result {
        Ok(msg) => msg.try_into(),
        Err(e) => Err(e.to_string().into()),
    }
}

/// @noRd
#[savvy]
pub fn rq_to_sql(rq_json: &str) -> savvy::Result<Sexp> {
    let result = Ok(rq_json)
        .and_then(prql_compiler::json::to_rq)
        .and_then(|x| prql_compiler::rq_to_sql(x, &prql_compiler::Options::default()));

    match result {
        Ok(msg) => msg.try_into(),
        Err(e) => Err(e.to_string().into()),
    }
}

/// @title prql-compiler's version
/// @return a prql-compiler's version string
/// @noRd
#[savvy]
pub fn compiler_version() -> savvy::Result<Sexp> {
    prql_compiler::COMPILER_VERSION.to_string().try_into()
}

/// @title Get available target names
/// @description Get available target names for the `target` option of the [prql_compile()] function.
/// @return a character vector of target names.
/// @examples
/// prql_get_targets()
/// @export
#[savvy]
pub fn prql_get_targets() -> savvy::Result<Sexp> {
    prql_compiler::Target::names().try_into()
}
