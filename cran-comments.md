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

## Changes addressing CRAN check issues

- Updated Rust dependencies, removing proc-macro-error2 and its
  future-incompatibility warning.
- Set the macOS deployment target for Rust C dependencies to avoid
  linker warnings when the SDK is newer than R's deployment target.

## R CMD check results

- There were no ERRORs or WARNINGs.
