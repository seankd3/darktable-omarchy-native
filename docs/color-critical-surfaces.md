# Color-Critical Surfaces

Darktable is used for judging exposure, contrast, color balance, noise, masks, and export decisions. A desktop theme can improve the surrounding app chrome, but it must not create a colored viewing booth around the photograph.

This integration therefore keeps the image workspace neutral:

- Darkroom canvas
- Center preview
- Lighttable preview
- Filmstrip image wells
- Thumbnail backing surfaces
- Histogram and navigation panels
- Mask/color picker surfaces
- Print/slideshow/map image review areas

The generated theme defines:

```css
@define-color omarchy_photo_canvas #262626;
@define-color omarchy_photo_canvas_foreground #e6e6e6;
@define-color omarchy_photo_canvas_border #3a3a3a;
```

Those roles are app-specific constraints, not global Omarchy tokens. They protect photographic judgment while allowing panels, controls, dialogs, focus rings, and selected states to feel native.

The rule of thumb is simple: if the surface frames or overlays a photo, keep it neutral; if it belongs to application chrome, map it to Omarchy tokens.
