# Screenshot Workflow

The deterministic demo path does not touch Darktable user configuration:

```bash
./scripts/generate-theme.sh --colors tests/fixtures/omarchy-fixture-colors.toml
./scripts/export-demo.sh
```

Outputs:

- `artifacts/themes/omarchy-darktable.css`
- `artifacts/screenshots/omarchy-darktable-demo.svg`

The SVG artifact is a high-fidelity static representation of the generated theme. It highlights the native chrome mapping while showing the neutral image canvas.

## Optional Live Darktable Capture

Darktable 5.4.1 is available on Sean's machine. To test the theme in the real application without mutating the normal profile, use a temporary config directory:

```bash
./scripts/capture-darktable.sh
```

Output:

- `artifacts/screenshots/darktable-live.png`

Blocker note: the automated check does not launch or control the GUI because that would depend on the active desktop session and could disrupt the user's current windows. The repo ships the deterministic demo artifact for verification and keeps live capture as an explicit command.
