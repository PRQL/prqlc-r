vendor_crates <- function(path = ".") {
  rust_dir <- rprojroot::find_package_root_file("src", "rust", path = path)

  out_file <- file.path(rust_dir, "vendor.tar.xz")
  config_toml_file <- file.path(rust_dir, "vendor-config.toml")

  withr::local_dir(rust_dir)

  config_toml_content <- processx::run(
    "cargo",
    c(
      "vendor",
      "--locked"
    )
  )$stdout

  rextendr:::write_file(
    text = config_toml_content,
    path = config_toml_file,
    search_root_from = path,
    quiet = TRUE
  )

  tar_flags <- "--sort=name --mtime='1970-01-01 00:00:00Z' --owner=0 --group=0 --numeric-owner"

  withr::local_dir(file.path(rust_dir, "vendor"))
  tar(
    out_file,
    compression = "xz",
    compression_level = 9,
    extra_flags = tar_flags
  )
}

vendor_crates()
