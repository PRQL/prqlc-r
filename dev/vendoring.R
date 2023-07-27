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

  withr::local_dir(file.path(rust_dir, "vendor"))
  withr::local_envvar(c(XZ_OPT = "-9"))
  processx::run(
    "tar",
    c(
      "-c",
      "-f", out_file,
      "--xz",
      "--sort=name",
      "--mtime=1970-01-01",
      "--owner=0",
      "--group=0",
      "--numeric-owner",
      "."
    )
  )
}

vendor_crates()
