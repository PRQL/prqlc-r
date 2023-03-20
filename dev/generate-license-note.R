# A script to generate LICENSE.note
# cargo-license <https://crates.io/crates/cargo-license> must be installed on the system to use this.
#
# Usage: Rscript dev/generate-license-note.R

manifest_path <- file.path("src", "rust", "Cargo.toml")
license_note_path <- file.path("LICENSE.note")

note_header <- paste0(
  "The binary compiled from the source code of this package contains the following Rust packages.\n",
  "\n",
  "\n",
  "-------------------------------------------------------------"
)

package_name <- RcppTOML::parseTOML(manifest_path)$package$name

list_license <- processx::run(
  "cargo",
  c(
    "license",
    "--authors",
    "--json",
    "--avoid-build-deps",
    "--avoid-dev-deps",
    "--manifest-path", manifest_path
  )
)$stdout |>
  jsonlite::parse_json()

.prep_authors <- function(authors, name) {
  ifelse(!is.null(authors), authors, paste0(name, " authors")) |>
    gsub(r"(\ <.+?>)", "", x = _) |>
    gsub(r"(\|)", ", ", x = _)
}

license_note <- list_license |>
  purrr::keep(\(x) x$name != package_name) |>
  purrr::map_chr(
    \(x) {
      paste0(
        "\n",
        "Name:        ", x$name, "\n",
        "Repository:  ", x$repository, "\n",
        "Authors:     ", .prep_authors(x$authors, x$name), "\n",
        "License:     ", x$license, "\n",
        "\n",
        "-------------------------------------------------------------"
      )
    }
  )

c(note_header, license_note) |>
  writeLines(license_note_path)
