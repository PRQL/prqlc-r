# Releasing binary Rust libraries

The release flow follows the approach in r-polars, with an explicit reusable
workflow call so that releases created using GITHUB_TOKEN also produce a metadata
PR without relying on a release event.

## One-time repository setting

In Settings > Actions > General > Workflow permissions, enable **Allow GitHub
Actions to create and approve pull requests**. The workflows request contents:
write and pull-requests: write only for jobs that publish releases or open PRs.
No additional token secret is required.

## Release

1. Set the new library version in src/rust/Cargo.toml and update Cargo.lock as
   needed. Merge the source changes into main. Each release needs a new version;
   an existing release is never overwritten.
2. Run **release-lib** from the Actions tab, selecting main (or run
   `gh workflow run release-lib.yml --ref main`). PR runs and dispatches on other
   branches build and test only; publication is restricted to dispatches on main.
3. After builds and tests pass, the workflow creates the lib-vVERSION tag at the
   tested commit and publishes a prerelease containing all binary archives,
   sha256sums.txt, and md5sums.txt.
4. The workflow calls **Update binary library metadata**, downloads the checksums
   from that exact release, and opens or updates a PR from automation/lib-sums.
   Review and merge its changes to tools/lib-sums.tsv and
   Config/prqlr/LibVersion in DESCRIPTION.

The metadata generator uses base R only. It checks that the release tag matches
main's Cargo package version, rejects malformed or duplicate checksums and
unexpected filenames, and sorts the TSV by URL. If main has moved to a new Cargo
version during the build, generation fails rather than pointing it at an old
binary release.

GITHUB_TOKEN-generated PRs may require approval to start their workflow runs;
see GitHub's [token event rules](https://docs.github.com/en/actions/concepts/security/github_token#when-github_token-triggers-workflow-runs).

## Retry metadata generation

If the release succeeded but metadata generation or PR creation failed, run
**Update binary library metadata** manually with the existing release tag:

```sh
gh workflow run build-lib-sums.yml --ref main -f tag=lib-vVERSION
```

This does not rebuild binaries or modify the published release. The tag must
match main's Cargo version. Fix repository permissions first if PR creation was
denied.

## Local validation

```sh
Rscript .github/scripts/test-generate-lib-sums.R
mise exec -- actionlint
mise exec -- pinact run --check --verify-comment
```

pinact and actionlint are installed globally through mise. To regenerate metadata
locally from a downloaded checksum file:

```sh
Rscript .github/scripts/generate-lib-sums.R lib-vVERSION /path/to/sha256sums.txt
```
