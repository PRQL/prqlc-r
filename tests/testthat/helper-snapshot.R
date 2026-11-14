mask_prqlc_version <- function(x) {
  gsub(as.character(prql_version()), "<PRQLC_VERSION>", x, fixed = TRUE)
}
