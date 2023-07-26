vendor_crates <- function(path = ".") {
  withr::local_dir(path)

  manifest_file <- file.path("src", "rust", "Cargo.toml")
  vendor_dir <- file.path("src", "rust", "vendor")
  out_file <- rprojroot::find_package_root_file("src", "rust", "vendor.tar.xz")
  config_toml_file <- file.path("src", "rust", "vendor-config.toml")

  config_toml_content <- processx::run(
    "cargo",
    c(
      "vendor",
      "--locked",
      "--manifest-path", manifest_file,
      vendor_dir
    )
  )$stdout

  rextendr:::write_file(
    text = config_toml_content,
    path = config_toml_file,
    search_root_from = path,
    quiet = TRUE
  )

  tar_flags <- "--sort=name --mtime='1970-01-01 00:00:00Z' --owner=0 --group=0 --numeric-owner"

  if (!dir.exists("tools")) dir.create("tools", recursive = TRUE)

  withr::local_dir(vendor_dir)
  tar(
    out_file,
    compression = "xz",
    compression_level = 9,
    extra_flags = tar_flags
  )
}

vendor_crates()
