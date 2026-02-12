# Element Reference

Use this file when you need exact field expectations for Excalidraw elements.

## Common required fields (all elements)

- `type`
- `id`
- `x`, `y`
- `width`, `height`
- `angle`
- `strokeColor`, `backgroundColor`
- `fillStyle`, `strokeWidth`, `strokeStyle`
- `roughness`, `opacity`
- `seed`, `version`, `versionNonce`
- `isDeleted`
- `groupIds`
- `boundElements`
- `link`
- `locked`

## Rectangle

Use for process blocks, containers, and cards.

- `type: "rectangle"`
- Optional rounded corners: `roundness: { "type": 3 }`

## Ellipse

Use for start/end nodes, bubbles, and circular entities.

- `type: "ellipse"`

## Diamond

Use for decisions and branching points.

- `type: "diamond"`

## Text

Use for labels and descriptions.

Additional fields:

- `text`
- `fontSize`
- `fontFamily` (`1` Virgil, `2` Helvetica, `3` Cascadia)
- `textAlign`
- `verticalAlign`
- `containerId`
- `originalText`
- `autoResize`
- `lineHeight`

## Arrow

Use for directional flow.

Additional fields:

- `points` (at least two points)
- `startArrowhead`
- `endArrowhead`
- `startBinding`
- `endBinding`

When binding to shapes, update both sides:

1. Set `startBinding`/`endBinding` on the arrow.
2. Add `{ "id": "<arrow-id>", "type": "arrow" }` to each bound shape's `boundElements`.

## Line

Use for non-directional connections.

Additional fields:

- `points`
- No arrowheads unless switching to `type: "arrow"`.
