---
layout: page
title: Agentspotter Context
permalink: /agentspotter/context/
---

This page mirrors the current context published in the `agent-spotter` GitHub README, plus links to the canonical docs.

## README Context

This `agentspotter` project is a small public experiment for observing whether web visitors behave like passive fetchers or interactive clients that can follow instructions and submit a valid follow-up request.

The docs are split by purpose so it is easy to navigate:

- `context.md` explains why the experiment exists
- `implementation.md` is the authoritative build contract
- `plan.md` is the execution plan aligned to that contract
- `copy.md` is website copy

## Signal Model

- `resource`: invitation/canary markdown read (`/llms.txt`, `/ai/recipe.md`, `/banana-muffins.md`)
- `fetch`: instruction fetch (`GET /agent.txt`)
- `hi_get`: lightweight follow-through (`GET /hi`)
- `hi_post`: stronger follow-through (`POST /hi` without token)
- `hi_post_token`: strongest follow-through in this setup (`POST /hi` with valid token)

## Deployment Notes From README

### Railway backend deployment

The FastAPI backend is deployed on Railway from repo root via `Dockerfile`.

Required env vars:

- `SALT`: strong unique secret
- `TRUST_PROXY_HEADERS`: `false` by default; set `true` only if reverse-proxy behavior is explicitly verified
- `FRONTEND_API_TOKEN`: shared bearer token for frontend `/events` calls
- `DATABASE_PATH=/data/events.db`: required for durable writes in managed runtime

Durability guidance:

- mount a Railway Volume at `/data`
- without a volume, SQLite writes can disappear after redeploy/replacement
- use `GET /health` for readiness/liveness checks
- avoid `GET /agent.txt` for health probes, because it intentionally records `fetch`

### Streamlit frontend deployment (legacy path)

Frontend can be deployed separately with `frontend/app.py`.

Streamlit secrets typically include:

```toml
BACKEND_URL = "https://your-backend.up.railway.app"
FRONTEND_API_TOKEN = "replace-with-the-same-token-you-set-on-railway"
```

`BACKEND_URL` is config; `FRONTEND_API_TOKEN` is the shared secret and must match Railway.

## Canonical Sources

- README: [github.com/sow451/agent-spotter](https://github.com/sow451/agent-spotter)
- Context doc: [context.md](https://github.com/sow451/agent-spotter/blob/main/context.md)
- Implementation contract: [implementation.md](https://github.com/sow451/agent-spotter/blob/main/implementation.md)
- Plan: [plan.md](https://github.com/sow451/agent-spotter/blob/main/plan.md)
