# Releasing binary Rust libraries

1. Update the library version in `src/rust/Cargo.toml` and `Cargo.lock`, then
   merge into main. Use a new version for each release.
2. Run **release-lib** from the Actions tab on main:

   ```sh
   gh workflow run release-lib.yml --ref main
   ```

3. After builds and tests pass, the workflow publishes `lib-vVERSION` and opens
   a PR updating `tools/lib-sums.tsv` and `Config/prqlr/LibVersion` in DESCRIPTION.
   Review and merge the PR.

## Retry the metadata update

If publication succeeded but the metadata update failed, rerun it with the
published tag, which must match main's Cargo version:

```sh
gh workflow run build-lib-sums.yml --ref main -f tag=lib-vVERSION
```

This reuses the existing release without rebuilding binaries.
