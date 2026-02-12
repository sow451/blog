# Best Practices

Use this file when diagram quality matters (readability, consistency, and visual semantics).

## Style defaults

- `strokeColor`: `#1e1e1e`
- `strokeWidth`: `2`
- `fillStyle`: `solid`
- `roughness`: `0` for formal technical docs, `1` for casual sketches
- `fontFamily`: `2` (Helvetica) unless hand-drawn style is requested

## Color semantics

- Info/input: blue (`#a5d8ff`)
- Success/data state: green (`#b2f2bb`)
- Decision/warning: yellow (`#ffec99`)
- Error/risk: red (`#ffc9c9`)
- Neutral/grouping: gray (`#e9ecef`)

## Spacing and alignment

- Major blocks: keep `100+` px spacing.
- Related siblings: keep `50-80` px spacing.
- Align by shared edges or centers; avoid near-miss alignment.
- Prefer orthogonal visual flow (top-to-bottom or left-to-right).

## Connector conventions

- Solid arrows: primary action flow.
- Dashed arrows: async, callback, or secondary flow.
- Minimize crossing lines; reroute with extra waypoints when needed.

## Labeling rules

- Keep labels short and task-specific.
- Use verb-first labels for actions (for example, `Validate request`).
- Use noun labels for entities/components (for example, `Order Service`).
- Keep text centered inside containers unless a left-aligned table-like structure is intentional.
