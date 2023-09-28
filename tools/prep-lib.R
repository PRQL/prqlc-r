if (identical(.Platform$OS.type, "windows")) {
  vendor_sys_abi <- "pc-windows-gnu"
} else if (grepl("^darwin", R.version$os)) {
  vendor_sys_abi <- "apple-darwin"
} else if (identical(R.version$os, "linux-gnu")) {
  vendor_sys_abi <- "unknown-linux-musl"
} else {
  stop("Pre built binaries are not available for OS: ", R.version$os)
}

if ((R.version$arch %in% c("amd64", "x86_64"))) {
  vendor_cpu_abi <- "x86_64"
} else if (R.version$arch %in% c("arm64", "aarch64")) {
  vendor_cpu_abi <- "aarch64"
} else {
  stop("Pre built binaries are not available for Arch: ", R.version$arch)
}

target_triple <- paste0(vendor_cpu_abi, "-", vendor_sys_abi)

lib_data <- utils::read.table("tools/lib-sums.tsv", header = TRUE, stringsAsFactors = FALSE)
