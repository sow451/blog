---
layout: project
title: "Wordle Analysis + Quiz"
preview: "https://wordle-people.streamlit.app/"
year: "2026"
note: "A quiz to identify your personality based on your Wordle style"
image: "/images/projects/2026-wordle-people/thummbnail.png"

---
I retsarted playing Wordle this year, with a group of new friends. This month, after about 65 days, I exported our WhatsApp group chat, parsed everyone's Wordle results, and used the data to classify each player into a personality type. Some are wildcards, some are finishers. Much like life.

![Reed App Images](/images/projects/2026-wordle-people/types.png)


There's also a quiz so anyone can find their own type - WHAT WORDLE PLAYER TYPE ARE YOU?

---

## What it does

- **Parses** a WhatsApp iOS chat export and extracts Wordle scores per person per day
- **Computes** behavioural features: average score, consistency, fail rate, streak length, posting time, and more
- **Classifies** each player into one of six types: The Strategist, The Wildcard, The Reliable, The Ghost, The Competitor, The Wordsmith
- **Visualises** group stats and individual player profiles in an interactive Streamlit app
- **Hosts a quiz** so readers can find their own Wordle personality type

![Reed App Images](/images/projects/2026-wordle-people/quiz.png)


## The six types

| Type | Defining trait |
|------|---------------|
| The Strategist | Low scores, low variance — they have a system |
| The Wildcard | Nails it in 2 one day, X the next |
| The Reliable | Never fails, always finishes, never spectacular |
| The Ghost | Plays in bursts with long disappearing acts |
| The Competitor | Posts first, checks everyone else's score |
| The Wordsmith | Unusual openers, scenic routes, still arrives |

