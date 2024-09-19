# prqlr 0.9.0

## Breaking changes

- Based on [`prqlc`](https://github.com/prql/prql) 0.13.0 (#312)

## Bug fixes

- Fix to report rustc version even if installing with pre-built binaries. (#305)

## Miscellaneous

- On R-universe, installing with pre-built binaries is now default. (#305)
- The configure script now compares the package's MSRV and the rustc version,
  and if the rustc version is less than the MSRV, an warning message is displayed. (#311)

# prqlr 0.8.1

Just dependency updates. No user-facing changes.

# prqlr 0.8.0

## Breaking changes

- Switch from `extendr` to `savvy`. (Thanks @yutannihilation, #252)
  - The error message has been completely changed.
  - `prql_compile()`'s `target` option does not accept `NA` as `"sql.any"` anymore.

## New features

- Based on [`prqlc`](https://github.com/prql/prql) 0.11.2 (#257)

## Miscellaneous

- The GitHub repository used to develop this package has been moved to <https://github.com/PRQL/prqlc-r>.
  Other URLs are also changed accordingly. (#262, #263)

# prqlr 0.7.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.11.1 (#239, #242)

# prqlr 0.6.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.10.1 (#221, #229)

# prqlr 0.5.4

## New features

- `{prqlr}` can now be installed with "R source package with Rust library binary",
  inspired by the [arrow](https://arrow.apache.org/docs/r/) package,
  the [string2path](https://yutannihilation.github.io/string2path/) package,
  and the [polars](https://rpolars.github.io/) package.
  Available on all currently supported platforms (amd64 and arm64 Linux or macOS, and amd64 Windows).

  When `NOT_CRAN=ture` or `LIBPRQLR_BUILD=false` is set,
  the script `tools/prep-lib.R` will search the Internet for the available binary.

  ```r
  Sys.setenv(NOT_CRAN = "true")
  install.packages("prqlr")
  ```

  The URL and SHA256 hash of the available binaries are recorded in `tools/lib-sums.tsv`.
  (#187, #189, #190, #191)

# prqlr 0.5.3

## New features

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.5 (#179)

## Miscellaneous

- `prql` knitr engine requires `{knitr}` 1.44 or later. (#175)

# prqlr 0.5.2

From this version, CRAN releases include vendored dependent Rust crates source code.

## Miscellaneous

- Update the `Authors` field of the DESCRIPTION file and the `inst/AUTHORS` file's format. (#169, #172)

# prqlr 0.5.1

## Bug fixes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.4 (#164)

# prqlr 0.5.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.3 (#130, #137, #142, #145, #155)

## Bug fixes

- Support Rust 1.70 on Windows. (Thanks @yutannihilation, #138)

## Miscellaneous

- Some updates for adopting the (new) CRAN policy. (#148)
  - This package now includes the `inst/AUTHORS` file. (#150, #154, #160)
  - Set `SystemRequirements: Cargo (Rust's package manager), rustc` in the DESCRIPTION file. (#153)
  - This package now includes the `configure` and `configure.win` scripts to check the cargo command. (#149)
  - Set `CARGO_BUILD_JOBS=2` if not `NOT_CRAN=true` during installation. (#151)
  - Supports dependent Rust crates vendoring. (#152, #159)
  - Update the `LICENSE.note` file for Rust crates vendoring. (#156)

# prqlr 0.4.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.8.1 (#121, #125)

## New features

- A new engine option `info_string` of `prql` engine on `{knitr}` documents.
  See the vignette `vignette("knitr", "prqlr")` for details. (#120)

## Bug fixes

- `prql` knitr engine respect the `eval` chunk option. (#123)

## Internal changes

- knitr engine tests were updated for adapt to the new `{knitr}` version. (Thanks @yihui, #122)

# prqlr 0.3.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.6.1 (#97, #99, #101, #106, #113)
- The `prql_to_sql()` function (deprecated in favor of `prql_compile()` from `prqlr` 0.1.0) is removed. (#105)

## New features

- A new compile target `"sql.any"` can be specified in `prql_compile()`'s `target` option.
  This is the same as the traditional unspecified (`NULL`) target
  with respect to using the target specified in the header of the query as the target. (#97)
- An experimental new engine option `use_glue` of `prql` engine on `{knitr}` documents powered by the `{glue}` package.
  See the vignette `vignette("knitr", "prqlr")` for details. (#103)

## Bug fixes

- `prql` knitr engine compatibility with Quarto CLI 1.3 pre-release version. (Thanks @cderv, #110)

# prqlr 0.2.1

## Bug fixes

- Thanks to new version of `extendr` and `libR-sys`, `prqlr` can now be installed on arm64 Linux. (#90)
- Now buildable with Rust version 1.60 again (#94)

# prqlr 0.2.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.5.1 (#71, #77, #86)
- The option name of `prql_compile()` for specifying the compile target has been changed from `dialect` to `target`.
  The following two changes have also been made as a result of this change.
  - SQL dialects must be specified with the `sql.` prefix if they are to be targeted
    (e.g. `"duckdb"` -> `"sql.duckdb"`). (#71)
  - `prql_available_dialects()` is renamed to `prql_get_targets()`. (#85)

## New features

- `{prqlr}` registers `prql` engine for `{knitr}` when loaded.
  See the vignette `vignette("knitr", "prqlr")` for details. (#53, #57, #62)
- New function `prql_version()` which returns built-in prql-compiler version. (#51)
- `prql_compile()`'s options can be set by `options()`. (#70)

## Other improvements

- `prql_compile()` no longer leaks memory when an error occurs. (Thanks @sorhawell, #46, #52)

# prqlr 0.1.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.4.1
- `prql_compile()` is implemented and `prql_to_sql()` is deprecated.
- `json_to_prql()` and `prql_to_json()` are removed.

## Other improvements

- Changes to the installation process
  - `CARGO_HOME` is now set to the temporary directory during installation
    if the environment variable `NOT_CRAN` is not set to `true`
    [to avoid writing in HOME](https://github.com/r-rust/faq). (#25, #27, #29)

# prqlr 0.0.4

## Enhancements

- Changes to the installation process
  - Change Rust toolchain for Windows from GNU to MSVC. (#22)

# prqlr 0.0.3

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.3.1
- The `format_prql()` function is removed.

# prqlr 0.0.2

## Enhancements

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.11

# prqlr 0.0.1

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.9
