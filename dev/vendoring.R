vendor_crates <- function(path = ".") {
  src_dir <- rprojroot::find_package_root_file("src", path = path)

  out_file <- file.path(src_dir, "rust", "vendor.tar.xz")
  config_toml_file <- file.path(src_dir, "rust", "vendor-config.toml")

  vendor_rel_path <- file.path("rust", "vendor")

  withr::local_dir(src_dir)

  config_toml_content <- processx::run(
    "cargo",
    c(
      "vendor",
      "--locked",
      "--manifest-path", file.path("rust", "Cargo.toml"),
      vendor_rel_path
    )
  )$stdout

  brio::write_lines(
    text = config_toml_content,
    path = config_toml_file
  )

  withr::local_dir(file.path(src_dir, vendor_rel_path))
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
