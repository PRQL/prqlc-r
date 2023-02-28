## Test environments

- local: x86_64-pc-linux-gnu
- GitHub Actions
  - { os: macOS-latest, r: "release" }
  - { os: windows-latest, r: "release", rtools-version: "42" }
  - { os: ubuntu-latest, r: "devel", http-user-agent: "release" }
  - { os: ubuntu-latest, r: "release" }
- devtools
  - `check_rhub()`
  - `check_win_release()`

## R CMD check results

- There were no ERRORs or WARNINGs.

## revdepcheck results

There are currently no downstream dependencies for this package.

## Installation issues

This release is a small update that fixes problems with building Rust source code that were discovered in version 0.2.0.
