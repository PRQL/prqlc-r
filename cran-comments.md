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

## Notes

- The purpose of this submission is to keep prqlr 0.5.0, which has been archived from CRAN, existing on CRAN.
  - I don't fully understand why prqlr 0.5.0 was archived from CRAN,
    because CRAN was not contacted when prqlr 0.5.0 was archived.
    I also intend to send an email to CRAN asking why prqlr 0.5.0 was archived, but have not received a reply.
    So I don't know if this post fully fixes the prqlr 0.5.0 problem.
- The Rust dependencies are not vendored because the size of the tarball vendoring the Rust dependencies
  reached 12MB and does not meet the criteria for packages on CRAN.
  Rust dependencies are downloaded from Crates.io during installation.
