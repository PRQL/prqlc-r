.onLoad <- function(...) {
  if (requireNamespace("knitr", quietly = TRUE)) {
    knitr::knit_engines$set(prql = eng_prql)
  }
}
