---
layout: post
title:  Happy Father's Day - Web Game
categories: [General]
excerpt: I have 4 hours to build an endless-runner game as a Father's Day gift. 
---

tldr: Father's Day is tomorrow, and instead of falling into a consumerist trap and spending a lot of money buying something, I decided it might be fun to build my husband (and also father of my 2 kids) a simple game that he could play on his laptop. 

I've always loved mindless, or rather flow-state games where there are very few player actions, and the goal is clear - jump, duck, fall, restart. 

Last year, I went down the track of building games for my 7 year old, and it was a fun 3 weeks of learning and implementing. BUT I DID IT - I build a spelling companion that we still use!

Before I could 'level up' however, many people fell sick and life happened and holidays happened and I started a new job, and I had to shelve all my hobbies away for a few months. Here I am now, 6 months later, back at it - and Father's Day is as good a motivation as anything to get a new game going!

I have 4-5 hours today to complete this game, let's see how it goes. I'm relying on AI of course, and some tutorials - and I have a bunch of notes and tips from my previous experience building 3 games fo rmy 7yo (Dictation Potato, Backpack Go and OddEven Cat).Let's get started!


# The Mechanics

Any endless runner game (Dino Chrome game, Subway Surfer, Temple Run etc.) has a few basic components: 

1. Automatic movement: The character moves forward automatically.

2. Artefacts: The character interacts with these artefacts such as obstacles or loot, or power-ups.

3. Character actions: The character needs to react to the artefacts via actions such as jump, duck, or shoot.


There are many ways to build a game, but the simplest one I've found that helps me learn as I do, is to use JS, HTML and CSS. There's no need right now to use any kind of physics engine, or any complex levels/saving type structure, so we can focus on getting the basics right with just these 3. 

1. HTML <canvas> for drawing the game

2. Vanilla JS for game loop, collisions, scoring

3. CSS for layout + fonts

We also avoid setup overhead and can keep everything in a few files and easily customise art, sound etc. 