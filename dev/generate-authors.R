write_authors <- function(path = ".", quiet = FALSE, force = TRUE) {
  manifest_file <- rprojroot::find_package_root_file("src", "rust", "Cargo.toml", path = path)
  outfile <- rprojroot::find_package_root_file("inst", "AUTHORS", path = path)

  list_authors <- processx::run(
    "cargo",
    c(
      "license",
      "--authors",
      "--json",
      "--avoid-build-deps",
      "--avoid-dev-deps",
      "--manifest-path", manifest_file
    )
  )$stdout |>
    jsonlite::parse_json()

  package_names <- processx::run(
    "cargo",
    c(
      "metadata",
      "--no-deps",
      "--format-version", "1",
      "--manifest-path", manifest_file
    )
  )$stdout |>
    jsonlite::parse_json() |>
    purrr::pluck("packages") |>
    purrr::map_chr("name")

  .prep_authors <- function(authors, package) {
    ifelse(!is.null(authors), authors, paste0(package, " authors")) |>
      stringi::stri_replace_all_regex(r"(\ <.+?>)", "") |>
      stringi::stri_replace_all_regex(r"(\|)", ", ")
  }

  authors_header <- "The authors of the dependency Rust crates:"

  authors_body <- list_authors |>
    purrr::discard(function(x) x$name %in% package_names) |>
    purrr::map_chr(
      function(x) {
        paste0(
          "\n",
          x$name, " (version ", x$version, "):\n",
          "  ", .prep_authors(x$authors, x$name)
        )
      }
    )

  rextendr:::write_file(
    text = c(authors_header, authors_body),
    path = outfile,
    search_root_from = path,
    quiet = quiet
  )
}

write_authors(force = TRUE)