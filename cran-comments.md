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
- There was 1 NOTE.
  - New submission

## Resubmission

This is a resubmission.
However, it has been mostly rewritten since the last submission,
as I have incorporated upstream breaking changes since the last submission.

I have updated it so that it does not write to the user's home directory during the installation process.
I installed it on `docker.io/library/r-base` (Debian testing based container) and
verified that there are no more files in the home directory.
