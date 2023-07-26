vendor_crates <- function(path = ".") {
  manifest_file <- rprojroot::find_package_root_file("src", "rust", "Cargo.toml", path = path)
  vendor_dir <- rprojroot::find_package_root_file("vendor", path = path)
  out_file <- rprojroot::find_package_root_file("tools", "vendored-sources.tar.xz", path = path)

  processx::run(
    "cargo",
    c(
      "vendor",
      "--locked",
      "--manifest-path", manifest_file,
      vendor_dir
    ),
    echo = TRUE
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
