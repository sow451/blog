# Diagram Patterns

Use these layout templates to avoid ad-hoc positioning.

## Flowchart

Pattern:

1. Put start node at top center.
2. Stack process nodes vertically.
3. Place decision diamonds between branches.
4. Route "yes/no" branches left/right, then rejoin below.

Recommended spacing:

- Vertical gap: `90-120`
- Horizontal branch gap: `180-260`

## Architecture Diagram

Pattern:

1. Group by tiers: client, API, services, data.
2. Keep each tier in a horizontal band.
3. Draw arrows top-to-bottom or left-to-right consistently.
4. Use frames to separate trust zones or environments.

Recommended spacing:

- Tier gap: `140-220`
- Service sibling gap: `120-180`

## Sequence Diagram

Pattern:

1. Put actors/services across the top.
2. Draw vertical lifelines with lines.
3. Draw request/response arrows left-to-right.
4. Use dashed arrows for responses.

Recommended spacing:

- Participant gap: `180-240`
- Message gap: `60-90`

## Mind Map

Pattern:

1. Place central topic in middle.
2. Place first-level topics in a radial layout.
3. Place second-level topics around each first-level topic.
4. Keep branch colors consistent per branch.

Recommended spacing:

- First-level radius: `180-260`
- Second-level radius: `120-170`

## ERD

Pattern:

1. Render each entity as a rectangle with title + fields.
2. Align related entities in columns.
3. Connect relationships with labeled lines or arrows.
4. Keep crossing connectors to a minimum.

Recommended spacing:

- Entity column gap: `220-320`
- Row gap: `120-180`
