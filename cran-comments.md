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
- There was a NOTE: `Size of tarball: 12580250 bytes`
  - Most of this size is a tarball of vendored Rust source code,
    since this package contains all the Rust source code of the dependencies.

## Notes

- The purpose of this submission is to keep prqlr 0.5.0 and 0.5.1, which has been archived from CRAN, existing on CRAN.
  - I removed the vendored Rust source code when submitting prqlr 0.5.0 and 0.5.1 to reduce the unacceptably large package size
    for CRAN and set to download Rust crates from crates.io, which caused them to be archived from the CRAN repository.
    I then received an email from CRAN informing me that packages larger than 5 MB are allowed as long as they are for
    vendoring Rust source code.
