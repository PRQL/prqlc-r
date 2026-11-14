# Generate metadata for one specific release, never whichever release is latest.
generate_lib_sums <- function(tag, sums_path, root = ".") {
  cargo <- readLines(file.path(root, "src/rust/Cargo.toml"))
  package_start <- match("[package]", trimws(cargo))
  if (is.na(package_start)) stop("Cargo.toml has no [package] section")
  package <- cargo[seq.int(package_start + 1L, length(cargo))]
  next_section <- grep("^\\s*\\[", package)
  if (length(next_section)) package <- head(package, next_section[1L] - 1L)
  version_line <- grep('^\\s*version\\s*=\\s*"[^"]+"', package, value = TRUE)
  if (length(version_line) != 1L) stop("Cannot determine Cargo package version")
  version <- sub('^\\s*version\\s*=\\s*"([^"]+)".*$', "\\1", version_line)
  if (!identical(tag, paste0("lib-v", version))) {
    stop("Release tag does not match the Cargo package version: ", tag)
  }

  lines <- trimws(readLines(sums_path, warn = FALSE))
  lines <- lines[nzchar(lines)]
  if (!length(lines)) stop("Empty checksum file")
  entries <- strsplit(lines, "[[:space:]]+")
  if (any(lengths(entries) != 2L)) stop("Invalid checksum entry")
  hashes <- vapply(entries, `[`, "", 1L)
  filenames <- sub("^\\*", "", vapply(entries, `[`, "", 2L))
  prefix <- paste0("libprqlr-", version, "-")
  targets <- substring(filenames, nchar(prefix) + 1L)
  if (any(!grepl("^[[:xdigit:]]{64}$", hashes)) ||
      any(!startsWith(filenames, prefix)) ||
      any(!grepl("^[a-zA-Z0-9_-]+\\.tar\\.gz$", targets)) ||
      anyDuplicated(filenames)) {
    stop("Invalid, duplicate, or mismatched library checksum")
  }

  description_path <- file.path(root, "DESCRIPTION")
  description <- readLines(description_path)
  field <- grep("^Config/prqlr/LibVersion:", description)
  if (length(field) != 1L) stop("Expected one Config/prqlr/LibVersion field")
  description[field] <- paste("Config/prqlr/LibVersion:", version)
  urls <- paste0("https://github.com/PRQL/prqlc-r/releases/download/", tag, "/", filenames)
  rows <- paste(urls, tolower(hashes), sep = "\t")
  writeLines(c("url\tsha256sum", rows[order(urls)]), file.path(root, "tools/lib-sums.tsv"))
  writeLines(description, description_path)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) != 2L) stop("Usage: Rscript generate-lib-sums.R <lib-vVERSION> <sha256sums.txt>")
  generate_lib_sums(args[1L], args[2L])
}
