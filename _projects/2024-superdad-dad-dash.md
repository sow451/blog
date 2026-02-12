---
layout: project
title: "Superdad"
year: "2024"
preview: "https://superdad-omega.vercel.app/"
image: "/images/projects/2024-superdad-dad-dash.md/superdadscreenshot.png"
note: "A lightweight endless-runner game built with vanilla HTML, CSS, and JavaScript on canvas."
---

_tldr: I built a simple endless-runner game called **Superdad** as a fun browser game project._

The game is built with plain HTML, CSS, and JavaScript, with gameplay rendered on a `<canvas>`. You dodge moving obstacles, keep jumping, and try to survive as long as possible while the score keeps increasing. I initally built it as a last minute Father's Day gift for my husband, with a handdrawn diaper as the obstacle (instead of the football you currently see). The diaper icon was...not well drawn, so I switched it out for a football.

## What I built

- A custom game loop using `requestAnimationFrame`
- Obstacle spawning and collision detection
- Keyboard + tap controls for jump
- Score and best-score tracking
- Responsive game board sizing

## Why this project

I wanted to build something playful while learning core frontend fundamentals without a framework. This project helped me practice game logic, timing, physics basics, and UI polish in pure vanilla JS.

## Gameplay

<video controls preload="metadata" width="100%">
  <source src="/images/projects/2024-superdad-dad-dash.md/gameplay_superdad.mp4" type="video/mp4" />
  <source src="/images/projects/2024-superdad-dad-dash.md/gameplay_superdad.mov" type="video/quicktime" />
  Your browser does not support embedded video.
</video>
