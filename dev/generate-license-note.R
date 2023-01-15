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

df_license <- processx::run(
  "cargo",
  c("license", "--authors", "--tsv", "--avoid-build-deps", "--manifest-path", manifest_path)
)$stdout |>
  data.table::fread() |>
  dplyr::select(name, repository, authors, license) |>
  dplyr::filter(name != package_name) |>
  dplyr::mutate(
    authors = dplyr::case_when(
      authors == "" ~ paste0(name, " authors"),
      TRUE ~ authors
    ) |>
      stringr::str_remove_all(r"(\ <.+?>)") |>
      stringr::str_replace_all(r"(\|)", ", ")
  )

license_note <- df_license |>
  purrr::pmap_chr(
    \(name, repository, authors, license) {
      paste0(
        "\n",
        "Name:        ", name, "\n",
        "Repository:  ", repository, "\n",
        "Authors:     ", authors, "\n",
        "License:     ", license, "\n",
        "\n",
        "-------------------------------------------------------------"
      )
    }
  )

c(note_header, license_note) |>
  writeLines(license_note_path)
