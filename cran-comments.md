## Test environments

- local: x86_64-pc-linux-gnu
- GitHub Actions
  - {os: macos-latest,   r: 'release'}
  - {os: windows-latest, r: 'release'}
  - {os: ubuntu-latest,   r: 'devel', http-user-agent: 'release'}
  - {os: ubuntu-latest,   r: 'release'}
  - {os: ubuntu-latest,   r: 'oldrel-1'}
- devtools
  - `check_rhub()`
  - `check_win_release()`

## R CMD check results

- There were no ERRORs or WARNINGs.

## revdepcheck results

There are currently no downstream dependencies for this package.

## Resubmission

This is a resubmission.

- Use role="aut" for Rust dependencies.
- To reduce package size on CRAN, it does not vendor dependent Rust crates.
