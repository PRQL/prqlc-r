## Test environments

- local: x86_64-pc-linux-gnu
- GitHub Actions
  - { os: macos-latest, r: "release" }
  - { os: windows-latest, r: "release" }
  - { os: ubuntu-latest, r: "devel", http-user-agent: "release" }
  - { os: ubuntu-latest, r: "release" }
  - { os: ubuntu-latest, r: "oldrel-1" }
- devtools
  - `check_win_release()`

## R CMD check results

- There were no ERRORs or WARNINGs.
- Size of tarball is 9.5 MB (More than 5 MB).
  - Most of this size is a tarball of vendored Rust source code,
    since this package contains all the Rust source code of the dependencies.
  - This package has always vendored Rust source code on CRAN since version 0.5.2
    in September 2023, and the size has been over 9 MB.
