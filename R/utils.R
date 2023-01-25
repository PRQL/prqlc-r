#' @title Rust-like unwrapping of result. Useful to do error handling on the R side.
#' @param result a list where either element ok or err is NULL, or both if ok is a literal NULL.
#' @param call context of error or string used for error printing, could be omitted.
#' @return the ok-element of list , or a error will be thrown
#' @examples
#' # export unwrap for this example, only for internal use
#' unwrap <- prqlr:::unwrap
#'
#' # unwrap a result with the ok-value "foo"
#' unwrap(list(ok = "foo", err = NULL))
#'
#' # unwrap an err-result
#' tryCatch(
#'   unwrap(ok = NULL, err = "something happend on the rust side"),
#'   error = function(e) as.character(e)
#' )
#' @noRd
unwrap <- function(result, call = sys.call(1L)) {
  # if not result
  if (!inherits(result, "Result") && (!is.list(result) || !all(names(result) %in% c("ok", "err")))) {
    stop("Internal error: cannot unwrap non result")
  }

  # if result is ok (ok can be be valid null, hence OK if both ok and err is null)
  if (is.null(result$err)) {
    return(result$ok)
  }

  # if result is error, raise R errors. Modify the error formatting as necessary.
  if (is.null(result$ok) && !is.null(result$err)) {
    stop(result$err)

    # add some custom error context, or just delete
    # stop(
    #   paste(
    #     result$err,
    #     paste(
    #       "\nwhen calling:\n",
    #       paste(
    #         capture.output(print(call)),collapse="\n")
    #     )
    #   )
    # )
  }

  # if not ok XOR error, then it must be another internal error.
  stop("Internal error: result object corrupted")
}
