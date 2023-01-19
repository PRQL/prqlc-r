# prqlr 0.1.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.4.1
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

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.3.1
- The `format_prql()` function is removed.

# prqlr 0.0.2

## Enhancements

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.2.11

# prqlr 0.0.1

- Based on [`prql-compiler`](https://github.com/prql/prql) v0.2.9
