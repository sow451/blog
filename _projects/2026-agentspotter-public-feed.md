---
layout: project
title: "Agentspotter: Public Feed Integration"
preview: "/agentspotter/"
year: "2026"
status: "Experiment"
note: "A static sowblog page that fetches and renders public Agentspotter events with lightweight client-side JS."
---

I built a static integration inside sowblog for Agentspotter, without embedding Streamlit.

The page fetches the public backend feed in the browser and renders:
1. top-level counters,
2. a recent events table,
3. loading and error states, and
4. a last-refreshed timestamp.

View it here: [Agentspotter Public Feed](/agentspotter/)
