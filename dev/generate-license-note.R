write_license_note <- function(path = ".", quiet = FALSE, force = TRUE) {
  manifest_file <- rprojroot::find_package_root_file("src", "rust", "Cargo.toml", path = path)
  outfile <- rprojroot::find_package_root_file("LICENSE.note", path = path)

  list_license <- processx::run(
    "cargo",
    c(
      "license",
      "--authors",
      "--json",
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

  separator <- "-------------------------------------------------------------"

  note_header <- paste0(
    "The following Rust crates are used or included in this package:\n",
    "\n",
    "\n",
    separator
  )

  note_body <- list_license |>
    purrr::discard(function(x) x$name %in% package_names) |>
    purrr::map_chr(
      function(x) {
        paste0(
          "\n",
          "Name:        ", x$name, "\n",
          "Version:     ", x$version, "\n",
          "Repository:  ", x$repository, "\n",
          "Authors:     ", .prep_authors(x$authors, x$name), "\n",
          "License:     ", x$license, "\n",
          "\n",
          separator
        )
      }
    )

  brio::write_lines(
    text = c(note_header, note_body),
    path = outfile
  )
}

write_license_note(force = TRUE)
