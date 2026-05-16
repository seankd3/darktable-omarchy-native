# darktable-omarchy-native

Downstream Darktable integration built on Omarchy Native Kit.

This repo owns the app-specific Darktable work: generated theme artifacts, install and rollback scripts, visual demos, acceptance checks, and research notes. Omarchy Native Kit stays the generic toolkit dependency; Darktable-specific polishing lives here.

## Quick Start

Generate the theme from the active Omarchy palette:

```bash
./scripts/generate-theme.sh
```

Generate from the deterministic fixture palette:

```bash
./scripts/generate-theme.sh --colors tests/fixtures/omarchy-fixture-colors.toml
```

Install the generated theme into your user Darktable profile:

```bash
./scripts/install-theme.sh
```

Then open Darktable preferences and select `omarchy`. Roll back by selecting another Darktable theme and running:

```bash
./scripts/rollback.sh
```

## What Gets Styled

The generated CSS maps Omarchy semantic colors onto Darktable chrome: side panels, module headers, module groups, buttons, entries, comboboxes, Bauhaus sliders, tabs, selected states, focus rings, scrollbars, tooltips, popovers, dialogs, filmstrip/list/table surfaces, and status colors.

Photo-review surfaces intentionally stay neutral: center preview, darkroom canvas, lighttable preview, thumbnails, filmstrip image wells, histograms, masks, and color labels keep Darktable-style grey references where color judgment matters.

## Commands

```bash
./scripts/generate-theme.sh
./scripts/install-theme.sh
./scripts/rollback.sh
./scripts/watch-theme.sh
./scripts/export-demo.sh
./scripts/capture-darktable.sh
./scripts/check.sh
```

Useful environment variables:

- `ONK_CLI`: path to the Omarchy Native Kit CLI. Defaults to `../omarchy-native-kit/dist/cli.js`.
- `DARKTABLE_THEME_DIR`: user theme install directory. Defaults to `$HOME/.config/darktable/themes`.
- `DARKTABLE_THEME_NAME`: installed CSS filename only. Defaults to `omarchy.css`.
- `OMARCHY_THEME_DIR`: active Omarchy theme directory for watch mode. Defaults to `$HOME/.config/omarchy/current/theme`.

## Artifacts

- Generated theme: `artifacts/themes/omarchy-darktable.css`
- Demo page: `demo/index.html`
- Demo screenshot artifact: `artifacts/screenshots/omarchy-darktable-demo.svg`
- Optional live capture: `artifacts/screenshots/darktable-live.png`

See [docs/native-mapping.md](docs/native-mapping.md), [docs/color-critical-surfaces.md](docs/color-critical-surfaces.md), and [docs/screenshot-workflow.md](docs/screenshot-workflow.md) for the integration contract.
