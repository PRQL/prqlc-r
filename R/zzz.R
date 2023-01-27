.onLoad <- function(...) {
  if (isNamespaceLoaded("knitr") && "knit_engines" %in% getNamespaceExports("knitr")) {
    knitr::knit_engines$set(prql = eng_prql)
  } else {
    setHook(
      packageEvent("knitr", "onLoad"), function(...) {
        knitr::knit_engines$set(prql = eng_prql)
      }
    )
  }

  invisible()
}
