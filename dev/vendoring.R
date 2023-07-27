vendor_crates <- function(path = ".") {
  src_dir <- rprojroot::find_package_root_file("src", path = path)

  out_file <- file.path(src_dir, "rust", "vendor.tar.xz")
  config_toml_file <- file.path(src_dir, "rust", "vendor-config.toml")

  withr::local_dir(src_dir)

  config_toml_content <- processx::run(
    "cargo",
    c(
      "vendor",
      "--locked",
      "--manifest-path", file.path("rust", "Cargo.toml"),
      file.path("rust", "vendor")
    )
  )$stdout

  rextendr:::write_file(
    text = config_toml_content,
    path = config_toml_file,
    search_root_from = path,
    quiet = TRUE
  )

  withr::local_dir(file.path(src_dir, "rust", "vendor"))
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
