---
layout: page
title: Agentspotter Context
permalink: /agentspotter/context/
---

Agentspotter is a small public experiment on instruction-following behavior in open web traffic.

The core question is: if a machine-readable page asks callers to say hi back, how often does follow-through happen?

## How to Read the Signals

- `resource`: invitation/canary markdown read (`/llms.txt`, `/ai/recipe.md`, `/banana-muffins.md`)
- `fetch`: instruction fetch (`GET /agent.txt`)
- `hi_get`: lightweight follow-through (`GET /hi`)
- `hi_post`: stronger follow-through (`POST /hi` without token)
- `hi_post_token`: strongest follow-through in this setup (`POST /hi` with valid token)

## What This Is Not

- Not identity verification
- Not proof of autonomy
- Not bot-proof attribution

## Full Method

Full context and methodology live in the project document:
[context.md](https://github.com/sow451/agent-spotter/blob/main/context.md)
