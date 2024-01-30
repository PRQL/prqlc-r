
#include <stdint.h>
#include <Rinternals.h>
#include "rust/api.h"

static uintptr_t TAGGED_POINTER_MASK = (uintptr_t)1;

SEXP handle_result(SEXP res_) {
    uintptr_t res = (uintptr_t)res_;

    // An error is indicated by tag.
    if ((res & TAGGED_POINTER_MASK) == 1) {
        // Remove tag
        SEXP res_aligned = (SEXP)(res & ~TAGGED_POINTER_MASK);

        // Currently, there are two types of error cases:
        //
        //   1. Error from Rust code
        //   2. Error from R's C API, which is caught by R_UnwindProtect()
        //
        if (TYPEOF(res_aligned) == CHARSXP) {
            // In case 1, the result is an error message that can be passed to
            // Rf_errorcall() directly.
            Rf_errorcall(R_NilValue, "%s", CHAR(res_aligned));
        } else {
            // In case 2, the result is the token to restart the
            // cleanup process on R's side.
            R_ContinueUnwind(res_aligned);
        }
    }

    return (SEXP)res;
}

SEXP compile__impl(SEXP prql_query, SEXP target, SEXP format, SEXP signature_comment) {
    SEXP res = compile(prql_query, target, format, signature_comment);
    return handle_result(res);
}

SEXP prql_to_pl__impl(SEXP prql_query) {
    SEXP res = prql_to_pl(prql_query);
    return handle_result(res);
}

SEXP pl_to_rq__impl(SEXP pl_json) {
    SEXP res = pl_to_rq(pl_json);
    return handle_result(res);
}

SEXP rq_to_sql__impl(SEXP rq_json) {
    SEXP res = rq_to_sql(rq_json);
    return handle_result(res);
}

SEXP compiler_version__impl(void) {
    SEXP res = compiler_version();
    return handle_result(res);
}

SEXP prql_get_targets__impl(void) {
    SEXP res = prql_get_targets();
    return handle_result(res);
}


static const R_CallMethodDef CallEntries[] = {
    {"compile__impl", (DL_FUNC) &compile__impl, 4},
    {"prql_to_pl__impl", (DL_FUNC) &prql_to_pl__impl, 1},
    {"pl_to_rq__impl", (DL_FUNC) &pl_to_rq__impl, 1},
    {"rq_to_sql__impl", (DL_FUNC) &rq_to_sql__impl, 1},
    {"compiler_version__impl", (DL_FUNC) &compiler_version__impl, 0},
    {"prql_get_targets__impl", (DL_FUNC) &prql_get_targets__impl, 0},
    {NULL, NULL, 0}
};

void R_init_prqlr(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
