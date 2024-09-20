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
