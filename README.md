# NHL Draft Analytics Dashboard

A Tableau dashboard exploring NHL Draft data to look at trends in player selection, draft success, and where players come from. I built this because I wanted to work with real sports data and practice turning a messy dataset into something actually usable.

---

## Overview

Not every NHL draft pick makes it. Most don't, actually. I wanted to dig into the data and see what patterns show up. Does draft position really matter? Which countries are most represented? Are there draft classes that turned out way better than others?

This project goes from raw draft data all the way to an interactive Tableau dashboard that lets you filter and explore those questions yourself.

---

## The Questions

- How does draft position relate to NHL career length?
- Which countries produce the most picks?
- How many drafted players never stick in the NHL?
- Are certain rounds more hit-or-miss than others?

---

## The Dataset

The data includes draft year, draft position, team, player name, position, height, weight, nationality, career games played, and career points.

---

## Data Cleaning

The data needed a fair amount of work before it was ready to visualize. I removed duplicates, standardized country names, fixed data types, handled missing values, and merged the draft info with career stats. Nothing glamorous, but it's most of what the work actually was.

---

## The Dashboard

The finished dashboard in Tableau includes:

- KPI cards for total players drafted, average career games, average points, and draft success rate
- A scatter plot of draft position vs career games played
- A breakdown of picks by country
- Career success by draft round
- Filters for draft year, country, position, and round

---

## What I Found

A few things stood out. Canada produces the most picks by a wide margin, with the US and Sweden behind it. First round picks are more likely to have long careers, but there's still a real drop-off even within the first round — it's not as clean as you'd expect. And every single draft class has a big chunk of players who never really establish themselves in the NHL, which I knew anecdotally but it's different seeing it laid out across every year.

---

## Tools Used

Python (pandas), Tableau, GitHub

---

## Dashboard Preview

*(Screenshots coming soon)*

---

## What I Learned

This was my first time working with sports data end to end. The cleaning took longer than I expected — country names alone were a mess. I also got a lot more comfortable in Tableau, especially building dashboards that answer a specific question rather than just throwing charts on a page.
