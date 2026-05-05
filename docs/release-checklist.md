# Release Checklist

Run before publishing or opening a PR:

```bash
./scripts/generate-theme.sh --colors tests/fixtures/omarchy-fixture-colors.toml
./scripts/export-demo.sh
./scripts/check.sh
git status --short --branch
```

Confirm:

- The generated CSS exists under `artifacts/themes/`.
- The CSS contains the ONK base header and downstream Darktable integration marker.
- Chrome selectors cover panels, modules, controls, Bauhaus sliders, tabs, focus, status states, scrollbars, popovers, dialogs, lists, and tables.
- Photo canvas selectors stay mapped to neutral roles.
- Install and rollback remain explicit user actions.
- Demo artifacts exist under `artifacts/screenshots/`.
