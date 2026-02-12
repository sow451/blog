---
name: excalidraw
description: Create and edit Excalidraw diagrams programmatically in `.excalidraw` JSON format. Use when users ask for flowcharts, sequence diagrams, architecture diagrams, wireframes, ERDs, mind maps, or updates to existing Excalidraw files.
---

# Excalidraw Diagram Skill

Build or modify `.excalidraw` files directly as JSON.

## Follow this workflow

1. Determine whether to create a new diagram or edit an existing file.
2. For edits, load and preserve existing `elements`, `appState`, and `files` unless the user asks to reset them.
3. Create or update elements with valid required fields and stable IDs.
4. Arrange layout and styling for readability.
5. Save valid JSON with Excalidraw root fields.

## Use valid document shape

Always write this root structure:

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [],
  "appState": {
    "viewBackgroundColor": "#ffffff",
    "gridSize": null
  },
  "files": {}
}
```

## Apply element rules

- Set unique `id`, `seed`, and `versionNonce` per element.
- Include required geometry fields (`x`, `y`, `width`, `height`, `angle`).
- Keep `isDeleted: false`, `groupIds: []`, and `locked: false` unless requested otherwise.
- For arrows between shapes, set `startBinding` and `endBinding`, and add matching `boundElements` entries on connected shapes.
- Use `fontFamily: 2` for professional diagrams unless a hand-drawn style is requested.

For full per-element required fields and defaults, read `references/element-reference.md`.

## Pick the right pattern

- For flowcharts and decision trees, read `references/diagram-patterns.md` (Flowchart).
- For service/system views, read `references/diagram-patterns.md` (Architecture).
- For APIs and request timelines, read `references/diagram-patterns.md` (Sequence).
- For quick layout templates, read `references/examples.md`.
- For visual consistency and polish rules, read `references/best-practices.md`.

## Final checks before handing off

- Ensure JSON parses cleanly.
- Ensure arrows visually connect intended nodes.
- Ensure text is readable and not overlapping.
- Ensure spacing is consistent across siblings.
- Ensure colors and line styles encode meaning consistently.
