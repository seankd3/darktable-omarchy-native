# CODEX Report

## Summary

Built the downstream Darktable integration repo around the existing Omarchy Native Kit `integrate darktable` CLI. The repo now has opt-in generation, install, rollback, watch, check, deterministic demo, optional live capture, docs, fixture colors, a generated CSS artifact, and screenshot/demo artifacts.

The Darktable-specific styling stays downstream in `snippets/darktable-native-overrides.css`; Omarchy Native Kit was read but not modified.

## Files Changed

- `README.md`
- `CODEX_REPORT.md`
- `artifacts/themes/omarchy-darktable.css`
- `artifacts/screenshots/omarchy-darktable-demo.svg`
- `demo/index.html`
- `demo/styles.css`
- `docs/native-mapping.md`
- `docs/color-critical-surfaces.md`
- `docs/screenshot-workflow.md`
- `docs/release-checklist.md`
- `scripts/generate-theme.sh`
- `scripts/install-theme.sh`
- `scripts/rollback.sh`
- `scripts/watch-theme.sh`
- `scripts/export-demo.sh`
- `scripts/capture-darktable.sh`
- `scripts/check.sh`
- `snippets/darktable-native-overrides.css`
- `tests/fixtures/omarchy-fixture-colors.toml`

## Commits Made / Pushed

No commits were made or pushed from this sandbox. `git add` failed with:

```text
fatal: Unable to create '/home/sean/Projects/darktable-omarchy-native/.git/index.lock': Read-only file system
```

Controller commit command:

```bash
git add README.md CODEX_REPORT.md artifacts demo docs scripts snippets tests
git commit -m "Build downstream darktable integration pipeline"
git push origin main
```

## Verification Results

Passed:

```bash
./scripts/generate-theme.sh --colors tests/fixtures/omarchy-fixture-colors.toml
./scripts/export-demo.sh
./scripts/check.sh
git status --short --branch
```

`./scripts/check.sh` verifies the generated CSS exists, includes the ONK base marker, includes the downstream Darktable marker, covers key selectors/tokens, keeps neutral photo canvas roles, checks safe install/rollback script contracts, confirms docs mention rollback and live capture, and confirms demo artifacts exist.

Current git status:

```text
## main...origin/main
 M README.md
?? CODEX_REPORT.md
?? artifacts/
?? demo/
?? docs/
?? scripts/
?? snippets/
?? tests/
```

## Screenshot Paths

- Deterministic demo page: `/home/sean/Projects/darktable-omarchy-native/demo/index.html`
- Deterministic screenshot artifact: `/home/sean/Projects/darktable-omarchy-native/artifacts/screenshots/omarchy-darktable-demo.svg`
- Optional live capture target: `/home/sean/Projects/darktable-omarchy-native/artifacts/screenshots/darktable-live.png`

## Blockers

Live Darktable capture was attempted with a temporary config and in-memory library:

```bash
WAIT_SECONDS=5 ./scripts/capture-darktable.sh
```

It failed in the sandbox because GTK could not open the display:

```text
(darktable:11): Gtk-WARNING **: cannot open display: :1
```

The script is present for a normal desktop shell and does not mutate the user's standard Darktable config.

## Recommended Next Step

Run the controller commit commands above, then run `./scripts/capture-darktable.sh` from a normal interactive Wayland session to produce `artifacts/screenshots/darktable-live.png` for the first real-app visual proof.
