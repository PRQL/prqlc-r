SEXP compile(SEXP prql_query, SEXP target, SEXP format, SEXP signature_comment);
SEXP prql_to_pl(SEXP prql_query);
SEXP pl_to_rq(SEXP pl_json);
SEXP rq_to_sql(SEXP rq_json);
SEXP compiler_version(void);
SEXP prql_get_targets(void);
