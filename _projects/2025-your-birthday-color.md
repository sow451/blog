---
layout: project
title: "Your Birthday Color"
preview: "https://your-birthday-hex-color.streamlit.app/"
year: "2025"
status: "fun"
image: "/images/projects/2025-your-birthday-color.md/birthdaycolour_thumbnail.png"
note: "Wanted to show Python code w/o building UI, found Streamlit - built a birthday colour app!"
---

_tldr: I built a tiny app that turns your birth-date into a color._

## How it works:

You enter a date, the app converts it into a 6‑digit hex code, and it renders your “birthday color” as a swatch. It’s simple, playful, and deterministic (fancy way of saying that the same date always gives the same color.)

![A screenshot of the app](/images/projects/2025-your-birthday-color.md/birthday_1.png)

## Why it’s cool: 

It takes something personal (a birthday) and maps it into the 24‑bit RGB color space. That space has ~16.7M colors, so everyone gets a unique-ish result.

## What I learned:

I've used hex values for years without fully understanding the logic and maths behind it - so I spent some time indulging my interests by building this app! Also - I learnt how RGB values map to hex (#RRGGBB), and how 8 bits per channel gives you 256 levels × 3 channels = 16.7M colors.

Also, it took no more than a few mins, but I enjoyed figuring out how to safely fit large numbers into a 6‑digit hex range using modulo. This was a new one for me, if very basic. 

## New tech I explored:

This was my first quick project with Streamlit. I loved how fast it was to go from idea → UI → a working app without any frontend setup. I've since used Streamlit extensively when I need to showcase some Python i've built without a charting library.

## Next up/Wishlist:  

A color name lookup library for all possible hex values (16.7M hex colors), and tests for the date-to-hex conversion. I could have used the basic CSS colour library, but it wouldn't have 16.7 million values, and I care deeply about insignificant but cute details like this, so left the colour name blank and will amend when I have more time in the future!
