# prqlr (development version)

# prqlr 0.0.4

- Changes to the installation process
  - Change Rust toolchain for Windows from GNU to MSVC. (#22)
  - `CARGO_HOME` is now set to the temporary directory during installation
    if the environment variable `NOT_CRAN` is not set to `true`
    [to avoid writing in HOME](https://github.com/r-rust/faq). (#25, #27)

# prqlr 0.0.3

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.3.1
- The `format_prql` function is removed.

# prqlr 0.0.2

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.2.11

# prqlr 0.0.1

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.2.9
