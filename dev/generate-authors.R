write_authors <- function(path = ".", quiet = FALSE, force = TRUE) {
  manifest_file <- rprojroot::find_package_root_file("src", "rust", "Cargo.toml", path = path)
  outfile <- rprojroot::find_package_root_file("inst", "AUTHORS", path = path)

  gh_base_url <- "https://github.com/"

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

  dep_crates <- processx::run(
    "cargo",
    c(
      "license",
      "--json",
      "--manifest-path", manifest_file
    )
  )$stdout |>
    jsonlite::parse_json() |>
    tibble::as_tibble_col() |>
    tidyr::unnest_wider(value) |>
    dplyr::filter(!name %in% package_names) |>
    dplyr::pull(name) |>
    unique()

  authors_header <- "Owners of dependent Rust crates. This list is generated from Crates.io Data <https://crates.io/data-access>:"

  .old_wd <- getwd()
  .wd <- withr::local_tempdir()
  withr::local_dir(.wd)

  dump_file <- "db-dump.tar.gz"
  exdir <- "db-dump"

  curl::curl_download("https://static.crates.io/db-dump.tar.gz", dump_file)
  utils::untar(dump_file, exdir = "db-dump")

  withr::local_dir(fs::dir_ls(exdir))

  withr::local_options(list(readr.show_progress = FALSE, readr.show_col_types = FALSE))
  df_owners <- readr::read_csv("data/crate_owners.csv")
  df_crates <- readr::read_csv("data/crates.csv", col_types = list(max_upload_size = readr::col_integer()))
  df_users <- readr::read_csv("data/users.csv")

  df_owner_names <- df_crates |>
    dplyr::filter(name %in% dep_crates) |>
    dplyr::select(crate_id = id, crate_name = name) |>
    dplyr::left_join(
      df_owners |>
        dplyr::select(crate_id, owner_id),
      by = c("crate_id")
    ) |>
    dplyr::left_join(
      df_users |>
        dplyr::select(id, name, gh_login),
      by = c("owner_id" = "id")
    ) |>
    dplyr::arrange("owner_id") |>
    dplyr::mutate(
      name = stringr::str_c(name, " <", gh_base_url, gh_login, ">"),
      .keep = "unused"
    ) |>
    dplyr::filter(!dplyr::if_any(tidyselect::everything(), is.na)) |>
    dplyr::summarise(names = stringr::str_c(name, collapse = ", "), .by = crate_name) |>
    dplyr::arrange(crate_name)

  authors_body <- df_owner_names |>
    purrr::pmap_chr(\(crate_name, names) stringr::str_c("  - ", crate_name, ": ", names))

  withr::local_dir(.old_wd)

  rextendr:::write_file(
    text = c(authors_header, authors_body),
    path = outfile,
    search_root_from = path,
    quiet = quiet
  )
}

write_authors(force = TRUE)
