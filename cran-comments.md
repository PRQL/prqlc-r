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

```
❯ checking installed package size ... NOTE
    installed size is 14.6Mb
    sub-directories of 1Mb or more:
      libs  14.5Mb

❯ checking compilation flags used ... NOTE
  Compilation used the following non-portable flag(s):
    ‘-Wdate-time’ ‘-Werror=format-security’ ‘-Wformat’

0 errors ✔ | 0 warnings ✔ | 2 notes ✖
```
