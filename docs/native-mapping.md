# Native Mapping

This repo treats Darktable as a serious GTK creative application with two visual zones:

- System-native shell: app chrome that should inherit Omarchy personality.
- Color-critical workspace: image judgment surfaces that must stay neutral.

The pipeline starts with `omarchy-native integrate darktable`, then appends `snippets/darktable-native-overrides.css`. The ONK base defines the `@define-color omarchy_*` roles. The downstream layer maps those roles to Darktable's own GTK and `dt_*` selectors.

## Token Roles

| Omarchy role | Darktable use |
| --- | --- |
| `omarchy_background` | Window base, dialogs, menus, inactive empty chrome |
| `omarchy_foreground` | Primary shell text, labels, active module text |
| `omarchy_muted_foreground` | Placeholder text, secondary labels, disabled affordances |
| `omarchy_surface` | Side panels, module bodies, buttons, tabs, entries |
| `omarchy_surface_raised` | Hovered module headers, raised controls, tooltip/popover surfaces |
| `omarchy_border` | Panel separators, control outlines, inactive structure |
| `omarchy_border_strong` | Hover borders, popover/dialog edges, active structure |
| `omarchy_accent` | Focus rings, selected rows, active tabs, checked buttons, slider fill |
| `omarchy_accent_foreground` | Text and icons on selected/accent backgrounds |
| `omarchy_warning` | Darktable warning rows and warning infobars |
| `omarchy_danger` | Error rows and error infobars |
| `omarchy_success` | Success infobars and positive status states |
| `omarchy_info` | Info infobars and local-copy/status accents |
| `omarchy_photo_canvas` | Neutral photo review and preview surfaces |

## Surface Mapping

Windows, dialogs, popovers, menus, and tooltips use `background`, `foreground`, `surfaceRaised`, and border tokens so transient UI feels like the desktop instead of default Adwaita.

Left/right/top/bottom panels, module panels, library modules, iop modules, module controls, and module headers use `surface` for dense chrome and `surfaceRaised` for hover. This keeps Darktable's repeated panel structure scannable without tinting the photo.

Buttons, toggle buttons, model buttons, entries, search entries, spin buttons, comboboxes, lists, rows, tree views, and notebook tabs use `surface` and `border`. Checked, active, selected, and focused states use `accent`, with `accentForeground` for readable text.

Bauhaus controls are mapped through Darktable's own `bauhaus_*` colors and selectors: `.dt_bauhaus`, `#bauhaus-combobox`, `#bauhaus-slider`, `.dt_bauhaus_popup`, and `.dt_bauhaus_alignment`. The trough stays subdued; the active fill uses `accent`.

Scrollbars and scales map inactive tracks to muted foreground alpha, active sliders to `accent`, and backgrounds to a low-alpha black. This preserves compact Darktable controls while making active manipulation native.

Section labels, expanders, tabs, and notebook headers use foreground and border roles to keep module grouping clear. Module and library headers get the same hover treatment as buttons so the interactive surface is legible.

Warning, error, success, and info states map to Omarchy semantic status colors. These are intentionally strong because they communicate app state rather than image color.

Filmstrip, thumbnail, lighttable, darkroom, preview, histogram, navigation, masks, and color picker surfaces stay neutral through `omarchy_photo_canvas`, `omarchy_photo_canvas_foreground`, and `omarchy_photo_canvas_border`.

## Launcher Metadata

This repo does not install launcher metadata yet. If Darktable launcher metadata becomes part of the downstream product, it should live here as an opt-in artifact and should not mutate Omarchy hooks automatically.

## Boundary

No upstream Darktable C/GTK source is patched. No generic ONK changes are needed for the current integration: the existing CLI supplies the token bridge, and this repo supplies Darktable-specific depth.
