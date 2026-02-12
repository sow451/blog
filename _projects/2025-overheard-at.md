---
layout: project
title: "Overheard At"
preview: "https://example.com/overheard-at/"
order: 5
year: "2024"
image: "/images/projects/2025-overheard-at.md/overheard_at_thumbnail.png"
note: "A lightweight anonymous message board for conferences. I built it so attendees can share the funny, awkward, and memorable lines they overhear in hallways."
---

_tldr: Overheard At is a small conference side-project that lets people post anonymous hallway quotes in real time. I started it as a fun experiment, and it quickly turned into a neat product idea with moderation, duplicate checks, and simple anti-spam controls._

First, some background: This week I attended GFF 2025. In case you haven't heard of it - GFF is India's largest fintech conference. It takes place once a year, and pulls the attendance of who's who of fintech, finservices and well... anyone who's involved with touching money in anyway in India.

![A website with the title "Overheard at GFF" and some anonymous posts](/images/projects/2025-overheard-at.md/overheard_at_3.png)

Ahead of GFF, I built a tiny lightweight app I’ve wanted for myself: an anonymous, public, message board for the funny, and juicy gossip that people overhear at large industry forums - indluge me, don't judge. 

It’s intentionally simple: a single feed-page, an “Add” CTA + Modal, and quick sort controls so you can browse the newest/ oldest posts. No login, no profiles, no my grandmother told me a story type intro for SEO farming. 

<video controls width="100%">
  <source src="/images/projects/2025-overheard-at.md/vid_overheard_at_1.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

### What it does

1. Let's a user post some text anonymously with a 320-character limit.
2. No moderation by a human, some content moderation of the input text.
3. Upon successful posting, you can see your message on the feed instantly. A refresh button pulls the latest; new posts show up at the top.
4. Like/dislike exists - but doesn't get "saved" - bug to be fixed for later.
5. Mobile-first/friendly.
6. One page, clean spacing, neat UI (thanks shadcn).
  
  ![Add posts](/images/projects/2025-overheard-at.md/overheard_at_2.png)



### The stack:
1. Next.js for a single page + API routes.
2. Supabase for storage / SQL power.  
3. Shadcn components for the UI.


### How it works: 
At its heart, the app runs on Next.js (App Router) and Supabase. The backend lives entirely inside one API route, /api/submit. When someone submits a quote, it passes through a series of thoughtful filters — what I like to call “polite gatekeeping for dummies.”

### Filtering out profanity and spam - Zod, libraries:

[Zod](https://zod.dev/) validates the payload. The text must be between 5 and 320 characters. Optional fields like “who” and “where” get trimmed and sanitized automatically. If someone forgets to fill the main field, they get a friendly “This field is mandatory” message.

Next, there's a honeypot check to quietly (try to) catch bots. There’s an invisible field (nickname_check) that humans never see, but spam scripts almost always fill (says the internet). If that field contains anything, the code discards the post.

After passing this basic check, comes a quality check to filter out low quality posts — pure numbers, only punctuation, or only emoji spam -  all get filtered out. If a message passes those, it still has to dodge two more defenses:

A rate-limit (max five submissions per hour per IP, hashed for privacy).

A profanity filter, built with both English and Hindi libraries — [leo-profanity](https://github.com/jojoee/leo-profanity) and [profanity-hindi](https://github.com/surajJha/profanity-hindi).


That's it - if you pass through these 5 hoops - your post is in!

### Approved posts - Supabase
Messages that survive this process get inserted into Supabase with the status 'approved'. 

In the future, I might add moderation (and I did set up a table and statuses but decided I didn't want to build it right away), but for now, the app trusts its filters. 

There is another Supabase table to store logs for every event: validation failures, rate-limit hits, duplicate posts, and errors. This way, SQL queries can run inside Supabase and give a birds eye view of what’s happening under the hood.

### horny folks and regulator complaints

When OverheardAT went out into the world, I honstly assumed I'd hear real juicy goss about revenue metrics and raises (and honestly what was I thinking), there appeared a string of posts about hot girls, hot VCs and the odd crypto bro complaining about forbidden words!. Maybe we'll get the real gossip going next year!

![Here for beer!](/images/projects/2025-overheard-at.md/overheard_at_5.png)
