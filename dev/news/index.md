# Changelog

## prqlr (development version)

## prqlr 0.10.1

CRAN release: 2025-03-28

### Bug fixes

- Based on [`prqlc`](https://github.com/prql/prql) 0.13.4.
  ([\#357](https://github.com/PRQL/prqlc-r/issues/357))

### Miscellaneous

- Rewrite the `configure` script and `Makevars` files to pass R CMD
  check on R 4.5.0.
  ([\#347](https://github.com/PRQL/prqlc-r/issues/347),
  [\#351](https://github.com/PRQL/prqlc-r/issues/351),
  [\#356](https://github.com/PRQL/prqlc-r/issues/356),
  [\#361](https://github.com/PRQL/prqlc-r/issues/361),
  [\#363](https://github.com/PRQL/prqlc-r/issues/363))
- When installing the source package with the binary library from the
  web, `linux-gnu` and `linux-musl` are now distinguished. Previously,
  even on `linux-gnu` R, the `linux-musl` binary library was downloaded
  and used. ([\#359](https://github.com/PRQL/prqlc-r/issues/359),
  [\#360](https://github.com/PRQL/prqlc-r/issues/360))

## prqlr 0.10.0

CRAN release: 2025-01-29

### Breaking changes

- For the
  [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  funtion, arguments `format` and `singnature_comment` should be named
  arguments. ([\#317](https://github.com/PRQL/prqlc-r/issues/317))

### New features

- New experimental argument `display` of
  [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  function to colorize the error message from prqlc.
  ([\#317](https://github.com/PRQL/prqlc-r/issues/317))
- Based on [`prqlc`](https://github.com/prql/prql) 0.13.3
  ([\#336](https://github.com/PRQL/prqlc-r/issues/336))

## prqlr 0.9.0

CRAN release: 2024-09-20

### Breaking changes

- Based on [`prqlc`](https://github.com/prql/prql) 0.13.0
  ([\#312](https://github.com/PRQL/prqlc-r/issues/312))

### Bug fixes

- Fix to report rustc version even if installing with pre-built
  binaries. ([\#305](https://github.com/PRQL/prqlc-r/issues/305))

### Miscellaneous

- On R-universe, installing with pre-built binaries is now default.
  ([\#305](https://github.com/PRQL/prqlc-r/issues/305))
- The configure script now compares the package’s MSRV and the rustc
  version, and if the rustc version is less than the MSRV, an warning
  message is displayed.
  ([\#311](https://github.com/PRQL/prqlc-r/issues/311))

## prqlr 0.8.1

CRAN release: 2024-05-19

Just dependency updates. No user-facing changes.

## prqlr 0.8.0

CRAN release: 2024-02-14

### Breaking changes

- Switch from `extendr` to `savvy`. (Thanks
  [@yutannihilation](https://github.com/yutannihilation),
  [\#252](https://github.com/PRQL/prqlc-r/issues/252))
  - The error message has been completely changed.
  - [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)’s
    `target` option does not accept `NA` as `"sql.any"` anymore.

### New features

- Based on [`prqlc`](https://github.com/prql/prql) 0.11.2
  ([\#257](https://github.com/PRQL/prqlc-r/issues/257))

### Miscellaneous

- The GitHub repository used to develop this package has been moved to
  <https://github.com/PRQL/prqlc-r>. Other URLs are also changed
  accordingly. ([\#262](https://github.com/PRQL/prqlc-r/issues/262),
  [\#263](https://github.com/PRQL/prqlc-r/issues/263))

## prqlr 0.7.0

CRAN release: 2024-01-08

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.11.1
  ([\#239](https://github.com/PRQL/prqlc-r/issues/239),
  [\#242](https://github.com/PRQL/prqlc-r/issues/242))

## prqlr 0.6.0

CRAN release: 2023-11-14

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.10.1
  ([\#221](https://github.com/PRQL/prqlc-r/issues/221),
  [\#229](https://github.com/PRQL/prqlc-r/issues/229))

## prqlr 0.5.4

CRAN release: 2023-10-07

### New features

- [prqlr](https://prql.github.io/prqlc-r/) can now be installed with “R
  source package with Rust library binary”, inspired by the
  [arrow](https://arrow.apache.org/docs/r/) package, the
  [string2path](https://yutannihilation.github.io/string2path/) package,
  and the [polars](https://rpolars.github.io/) package. Available on all
  currently supported platforms (amd64 and arm64 Linux or macOS, and
  amd64 Windows).

  When `NOT_CRAN=ture` or `LIBPRQLR_BUILD=false` is set, the script
  `tools/prep-lib.R` will search the Internet for the available binary.

  ``` r

  Sys.setenv(NOT_CRAN = "true")
  install.packages("prqlr")
  ```

  The URL and SHA256 hash of the available binaries are recorded in
  `tools/lib-sums.tsv`.
  ([\#187](https://github.com/PRQL/prqlc-r/issues/187),
  [\#189](https://github.com/PRQL/prqlc-r/issues/189),
  [\#190](https://github.com/PRQL/prqlc-r/issues/190),
  [\#191](https://github.com/PRQL/prqlc-r/issues/191))

## prqlr 0.5.3

CRAN release: 2023-09-21

### New features

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.5
  ([\#179](https://github.com/PRQL/prqlc-r/issues/179))

### Miscellaneous

- `prql` knitr engine requires [knitr](https://yihui.org/knitr/) 1.44 or
  later. ([\#175](https://github.com/PRQL/prqlc-r/issues/175))

## prqlr 0.5.2

CRAN release: 2023-09-11

From this version, CRAN releases include vendored dependent Rust crates
source code.

### Miscellaneous

- Update the `Authors` field of the DESCRIPTION file and the
  `inst/AUTHORS` file’s format.
  ([\#169](https://github.com/PRQL/prqlc-r/issues/169),
  [\#172](https://github.com/PRQL/prqlc-r/issues/172))

## prqlr 0.5.1

CRAN release: 2023-08-30

### Bug fixes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.4
  ([\#164](https://github.com/PRQL/prqlc-r/issues/164))

## prqlr 0.5.0

CRAN release: 2023-08-13

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.9.3
  ([\#130](https://github.com/PRQL/prqlc-r/issues/130),
  [\#137](https://github.com/PRQL/prqlc-r/issues/137),
  [\#142](https://github.com/PRQL/prqlc-r/issues/142),
  [\#145](https://github.com/PRQL/prqlc-r/issues/145),
  [\#155](https://github.com/PRQL/prqlc-r/issues/155))

### Bug fixes

- Support Rust 1.70 on Windows. (Thanks
  [@yutannihilation](https://github.com/yutannihilation),
  [\#138](https://github.com/PRQL/prqlc-r/issues/138))

### Miscellaneous

- Some updates for adopting the (new) CRAN policy.
  ([\#148](https://github.com/PRQL/prqlc-r/issues/148))
  - This package now includes the `inst/AUTHORS` file.
    ([\#150](https://github.com/PRQL/prqlc-r/issues/150),
    [\#154](https://github.com/PRQL/prqlc-r/issues/154),
    [\#160](https://github.com/PRQL/prqlc-r/issues/160))
  - Set `SystemRequirements: Cargo (Rust's package manager), rustc` in
    the DESCRIPTION file.
    ([\#153](https://github.com/PRQL/prqlc-r/issues/153))
  - This package now includes the `configure` and `configure.win`
    scripts to check the cargo command.
    ([\#149](https://github.com/PRQL/prqlc-r/issues/149))
  - Set `CARGO_BUILD_JOBS=2` if not `NOT_CRAN=true` during installation.
    ([\#151](https://github.com/PRQL/prqlc-r/issues/151))
  - Supports dependent Rust crates vendoring.
    ([\#152](https://github.com/PRQL/prqlc-r/issues/152),
    [\#159](https://github.com/PRQL/prqlc-r/issues/159))
  - Update the `LICENSE.note` file for Rust crates vendoring.
    ([\#156](https://github.com/PRQL/prqlc-r/issues/156))

## prqlr 0.4.0

CRAN release: 2023-04-30

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.8.1
  ([\#121](https://github.com/PRQL/prqlc-r/issues/121),
  [\#125](https://github.com/PRQL/prqlc-r/issues/125))

### New features

- A new engine option `info_string` of `prql` engine on
  [knitr](https://yihui.org/knitr/) documents. See the vignette
  [`vignette("knitr", "prqlr")`](https://prql.github.io/prqlc-r/dev/articles/knitr.md)
  for details. ([\#120](https://github.com/PRQL/prqlc-r/issues/120))

### Bug fixes

- `prql` knitr engine respect the `eval` chunk option.
  ([\#123](https://github.com/PRQL/prqlc-r/issues/123))

### Internal changes

- knitr engine tests were updated for adapt to the new
  [knitr](https://yihui.org/knitr/) version. (Thanks
  [@yihui](https://github.com/yihui),
  [\#122](https://github.com/PRQL/prqlc-r/issues/122))

## prqlr 0.3.0

CRAN release: 2023-03-16

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.6.1
  ([\#97](https://github.com/PRQL/prqlc-r/issues/97),
  [\#99](https://github.com/PRQL/prqlc-r/issues/99),
  [\#101](https://github.com/PRQL/prqlc-r/issues/101),
  [\#106](https://github.com/PRQL/prqlc-r/issues/106),
  [\#113](https://github.com/PRQL/prqlc-r/issues/113))
- The `prql_to_sql()` function (deprecated in favor of
  [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  from `prqlr` 0.1.0) is removed.
  ([\#105](https://github.com/PRQL/prqlc-r/issues/105))

### New features

- A new compile target `"sql.any"` can be specified in
  [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)’s
  `target` option. This is the same as the traditional unspecified
  (`NULL`) target with respect to using the target specified in the
  header of the query as the target.
  ([\#97](https://github.com/PRQL/prqlc-r/issues/97))
- An experimental new engine option `use_glue` of `prql` engine on
  [knitr](https://yihui.org/knitr/) documents powered by the
  [glue](https://glue.tidyverse.org/) package. See the vignette
  [`vignette("knitr", "prqlr")`](https://prql.github.io/prqlc-r/dev/articles/knitr.md)
  for details. ([\#103](https://github.com/PRQL/prqlc-r/issues/103))

### Bug fixes

- `prql` knitr engine compatibility with Quarto CLI 1.3 pre-release
  version. (Thanks [@cderv](https://github.com/cderv),
  [\#110](https://github.com/PRQL/prqlc-r/issues/110))

## prqlr 0.2.1

CRAN release: 2023-02-28

### Bug fixes

- Thanks to new version of `extendr` and `libR-sys`, `prqlr` can now be
  installed on arm64 Linux.
  ([\#90](https://github.com/PRQL/prqlc-r/issues/90))
- Now buildable with Rust version 1.60 again
  ([\#94](https://github.com/PRQL/prqlc-r/issues/94))

## prqlr 0.2.0

CRAN release: 2023-02-18

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.5.1
  ([\#71](https://github.com/PRQL/prqlc-r/issues/71),
  [\#77](https://github.com/PRQL/prqlc-r/issues/77),
  [\#86](https://github.com/PRQL/prqlc-r/issues/86))
- The option name of
  [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  for specifying the compile target has been changed from `dialect` to
  `target`. The following two changes have also been made as a result of
  this change.
  - SQL dialects must be specified with the `sql.` prefix if they are to
    be targeted (e.g. `"duckdb"` -\> `"sql.duckdb"`).
    ([\#71](https://github.com/PRQL/prqlc-r/issues/71))
  - `prql_available_dialects()` is renamed to
    [`prql_get_targets()`](https://prql.github.io/prqlc-r/dev/reference/prql_get_targets.md).
    ([\#85](https://github.com/PRQL/prqlc-r/issues/85))

### New features

- [prqlr](https://prql.github.io/prqlc-r/) registers `prql` engine for
  [knitr](https://yihui.org/knitr/) when loaded. See the vignette
  [`vignette("knitr", "prqlr")`](https://prql.github.io/prqlc-r/dev/articles/knitr.md)
  for details. ([\#53](https://github.com/PRQL/prqlc-r/issues/53),
  [\#57](https://github.com/PRQL/prqlc-r/issues/57),
  [\#62](https://github.com/PRQL/prqlc-r/issues/62))
- New function
  [`prql_version()`](https://prql.github.io/prqlc-r/dev/reference/prql_version.md)
  which returns built-in prql-compiler version.
  ([\#51](https://github.com/PRQL/prqlc-r/issues/51))
- [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)’s
  options can be set by
  [`options()`](https://rdrr.io/r/base/options.html).
  ([\#70](https://github.com/PRQL/prqlc-r/issues/70))

### Other improvements

- [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  no longer leaks memory when an error occurs. (Thanks
  [@sorhawell](https://github.com/sorhawell),
  [\#46](https://github.com/PRQL/prqlc-r/issues/46),
  [\#52](https://github.com/PRQL/prqlc-r/issues/52))

## prqlr 0.1.0

CRAN release: 2023-01-20

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.4.1
- [`prql_compile()`](https://prql.github.io/prqlc-r/dev/reference/prql_compile.md)
  is implemented and `prql_to_sql()` is deprecated.
- `json_to_prql()` and `prql_to_json()` are removed.

### Other improvements

- Changes to the installation process
  - `CARGO_HOME` is now set to the temporary directory during
    installation if the environment variable `NOT_CRAN` is not set to
    `true` [to avoid writing in HOME](https://github.com/r-rust/faq).
    ([\#25](https://github.com/PRQL/prqlc-r/issues/25),
    [\#27](https://github.com/PRQL/prqlc-r/issues/27),
    [\#29](https://github.com/PRQL/prqlc-r/issues/29))

## prqlr 0.0.4

### Enhancements

- Changes to the installation process
  - Change Rust toolchain for Windows from GNU to MSVC.
    ([\#22](https://github.com/PRQL/prqlc-r/issues/22))

## prqlr 0.0.3

### Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.3.1
- The `format_prql()` function is removed.

## prqlr 0.0.2

### Enhancements

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.11

## prqlr 0.0.1

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.9
