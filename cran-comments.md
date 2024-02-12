## Test environments

- local: x86_64-pc-linux-gnu
- GitHub Actions
  - { os: macos-latest, r: "release" }
  - { os: windows-latest, r: "release" }
  - { os: ubuntu-latest, r: "devel", http-user-agent: "release" }
  - { os: ubuntu-latest, r: "release" }
  - { os: ubuntu-latest, r: "oldrel-1" }
- devtools
  - `check_rhub()`

## R CMD check results

- There were no ERRORs or WARNINGs.
- There was a NOTE about CRAN incoming feasibility: `Size of tarball: 15711133 bytes`
  - Most of this size is a tarball of vendored Rust source code,
    since this package contains all the Rust source code of the dependencies.
