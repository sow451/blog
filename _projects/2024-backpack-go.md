---
layout: project
title: "Backpack Go"
order: 11
year: "2024"
date: 2024-10-02
status: "Shipped"
preview: "https://backpackgo.vercel.app/"
image: "/images/projects/2024-backpack-go.md/backpackgo_thumbnail.png"
note: "A map-based learning game where kids enter latitude and longitude and discover where they land on Earth."
---
_Backpack Go_ started as an Inktober-inspired mini project and became a simple geography game for kids.

I made this game using pure HTML, CSS, and JavaScript in a couple of hours, as an extension of the Inktober 2024 prompt of the day: **Backpack**.

The player enters latitude and longitude values, and the map jumps to that point with a marker and location context. If the point lands in a water-heavy area, the game shows a message suggesting they may be in the ocean.

I designed it as a simple educational experience for children around 4-8 years old.

## What I learned

- Integrating Leaflet Maps
- Getting more familiar with latitude/longitude
- Using reverse geocoding with open APIs

## What I wanted to add (not done yet)

- Lat/long overlay lines on the map
- Returning the waterbody name using a marine geocoding source
- Restricting input length to 5 characters

## User testing note

I tested this with my 6-year-old. At first, it was tricky to land on actual land and not oceans, but once he got a few hits right, he was thrilled.
