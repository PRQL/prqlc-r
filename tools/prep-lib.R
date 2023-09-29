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

package_name <- read.dcf("DESCRIPTION", fields = "Package", all = TRUE)
lib_version <- read.dcf("DESCRIPTION", fields = sprintf("Config/%s/LibVersion", package_name), all = TRUE)
lib_tag_prefix <- "lib-"

target_url <- sprintf(
  "https://github.com/eitsupi/prqlr/releases/download/%s%s/libprqlr-%s-%s.tar.gz",
  lib_tag_prefix,
  lib_version,
  lib_version,
  target_triple
)

lib_sum <- lib_data |>
  subset(url == target_url) |>
  _$sha256sum

if (!length(lib_sum)) stop("No pre built binary found at <", target_url, ">")

message("Found pre built binary at <", target_url, ">. Downloading...")

destfile <- tempfile(fileext = ".tar.gz")

utils::download.file(target_url, destfile, quiet = TRUE, mode = "wb")
outfile <- utils::untar(destfile, exdir = "tools", list = TRUE)

message("Extracted pre built binary to <", file.path("tools", outfile), ">")
