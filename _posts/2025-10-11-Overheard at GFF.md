---
layout: post
title:  Overheard at GFF!
categories: [Build w AI,sideproject, conference]
excerpt: I went to GFF, and in preparation - this weekend, I built a tiny app I’ve wanted at every slightly stuffy and formal conference I've ever attended. It's a lightweight, anonymous message board for the funny, weird and bitchy things people say in hallways. I call it "Overheard At". Check it out!
---



This week I attended GFF 2025 - which, in case you haven't heard of it - is like India's largest fintech conference. It takes place once a year, and pulls the attendance of who's who of fintech, finservices and well... anyone who's involved with touching money in anyway in India.

I'll shortly write a note about what I actually learnt from my time at GFF, but before that I wanted to share a side project I worked on over this weekend. 
 
 psst: I used AI to write this paragraph and it sounds hopelessly tone-deaf but well, it got the point across?


Anyway, this weekend, I built a tiny app I’ve wanted at every slightly stuffy and formal conference I've ever attended: a lightweight, anonymous message board for the funny, bitchy or just plain weird things people say in hallways. 

I call it Overheard At! And for the conference I've just come from - its been productionized as 'Overheard at GFF'. 

![A website with the title "Overheard at GFF" and some anonymous posts](/images/posts/2025-10-11-Overheard%20at%20GFF/overheard_at_1.png)

![A website with the title "Overheard at GFF" and some anonymous posts](/images/posts/2025-10-11-Overheard%20at%20GFF/overheard_at_3.png)

It’s intentionally simple: a single feed-page, an “Add” CTA + Modal, and quick sort controls so you can browse the newest/ oldest posts. No login, no profiles, no my grandmother told me a story type intro for SEO farming. 

<video controls width="100%">
  <source src="/images/posts/2025-10-11-Overheard at GFF/vid_overheard_at_1.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

### What it does

1. Let's a user post some text anonymously with a 320-character limit.
2. No moderation by a human, some content moderation of the input text.
3. Upon successful posting, you can see your message on the feed instantly. A refresh button pulls the latest; new posts show up at the top.
4. Like/dislike exists - but doesn't get "saved" - bug to be fixed for later.
5. Mobile-first/friendly.
6. One page, clean spacing, neat UI (thanks shadcn).
  
  ![Add posts](/images/posts/2025-10-11-Overheard%20at%20GFF/overheard_at_2.png)



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

### Deployment was via Vercel

This was my first proper deployment, and I ran into multiple build errors that I had to fix using ChatGPT's assistance. Most were ESLint "warnings", that I had to silence/ clear up. 

![Deployment Errors!](/images/posts/2025-10-11-Overheard%20at%20GFF/overheard_at_4.png)


### voila!

Such a feeling of accomplishment. It was the end of Day 1 of the conference by the time I got the web-app deployed, so I didn't have enough time to socialise it.

### horny folks and regulator complaints

When OverheardAT went out into the world, I honstly assumed I'd hear real juicy goss about revenue metrics and raises (and honestly what was I thinking), there appeared a string of posts about hot girls, hot VCs and the odd crypto bro complaining about forbidden words!. Maybe we'll get the real gossip going next year!

![Here for beer!](/images/posts/2025-10-11-Overheard%20at%20GFF/overheard_at_5.png)

