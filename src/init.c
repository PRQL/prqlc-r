
#include <stdint.h>
#include <Rinternals.h>
#include <R_ext/Parse.h>

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

SEXP savvy_compile__impl(SEXP prql_query, SEXP target, SEXP format, SEXP signature_comment) {
    SEXP res = savvy_compile__ffi(prql_query, target, format, signature_comment);
    return handle_result(res);
}

SEXP savvy_prql_to_pl__impl(SEXP prql_query) {
    SEXP res = savvy_prql_to_pl__ffi(prql_query);
    return handle_result(res);
}

SEXP savvy_pl_to_rq__impl(SEXP pl_json) {
    SEXP res = savvy_pl_to_rq__ffi(pl_json);
    return handle_result(res);
}

SEXP savvy_rq_to_sql__impl(SEXP rq_json) {
    SEXP res = savvy_rq_to_sql__ffi(rq_json);
    return handle_result(res);
}

SEXP savvy_compiler_version__impl(void) {
    SEXP res = savvy_compiler_version__ffi();
    return handle_result(res);
}

SEXP savvy_prql_get_targets__impl(void) {
    SEXP res = savvy_prql_get_targets__ffi();
    return handle_result(res);
}


static const R_CallMethodDef CallEntries[] = {
    {"savvy_compile__impl", (DL_FUNC) &savvy_compile__impl, 4},
    {"savvy_prql_to_pl__impl", (DL_FUNC) &savvy_prql_to_pl__impl, 1},
    {"savvy_pl_to_rq__impl", (DL_FUNC) &savvy_pl_to_rq__impl, 1},
    {"savvy_rq_to_sql__impl", (DL_FUNC) &savvy_rq_to_sql__impl, 1},
    {"savvy_compiler_version__impl", (DL_FUNC) &savvy_compiler_version__impl, 0},
    {"savvy_prql_get_targets__impl", (DL_FUNC) &savvy_prql_get_targets__impl, 0},
    {NULL, NULL, 0}
};

void R_init_prqlr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);

    // Functions for initialzation, if any.

}
