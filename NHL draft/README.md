# NHL Draft Analysis Dashboard

## Overview

Not every first-round pick makes it, and some of the best NHL players were taken in the fourth round or later. I wanted to see if the data actually backed that up, and what other patterns show up when you look at decades of draft history all at once.

This project uses SQL to clean and prepare the data in PostgreSQL before bringing it into Tableau as an interactive dashboard you can explore by draft year, nationality, position, and round.

---

# The Questions I Looked At

### Does draft position actually matter?

Pretty much yes — earlier picks tend to play more games and put up more points over their careers. But it's not a clean line. There are first-rounders who flame out and sixth-rounders who play 1,000 games. That's what makes the draft interesting.

### Which rounds produce the most value?

The first round is the most reliable, but every round has produced legit NHL players. The drop-off is real, but it's not like rounds 4–7 are a wasteland either.

### Where do most NHL players come from?

Canada and the US make up the biggest share, but Sweden, Finland, Russia, and Czechia all show up consistently. Hockey talent is pretty concentrated geographically, but it's not exclusively North American.

### Does position matter for predicting success?

Forwards make up most of the career production, while defensemen and goalies follow different development paths. Goalies, in particular, are harder to evaluate because they often develop later and the sample sizes are much smaller.

---

# What I Actually Did

The raw data needed a lot of cleanup before it was usable. I standardized values, handled missing data, created derived columns like career tiers and draft ranges, and built reusable SQL views to answer the project's business questions.

After preparing the data in PostgreSQL, I exported the analysis views and built an interactive Tableau dashboard with KPI cards and visualizations that summarize long-term draft trends.

---

# What I Found

The biggest thing that stood out was how many drafted players never establish long NHL careers. That's something most hockey fans already know, but seeing it across decades of draft history really puts it into perspective.

The country breakdown was also interesting. Canada dominates the total number of drafted players, but when looking at success rates, several European countries perform surprisingly well relative to the number of players they produce.

---

# Dashboard Screenshots

## Main Dashboard

![Main Dashboard](./images/dashboard.png)

## Example SQL Screenshot

![SQL Example](./images/sql_example.png)

## Project Structure

![Project Structure](./images/project_structure.png)

---

# Tools Used

- SQL
- PostgreSQL
- pgAdmin 4
- Tableau Public
- Git & GitHub

---

# Why I Built This

I'm learning data analytics and wanted a project that focused on building an end-to-end SQL and Tableau workflow using a dataset I actually enjoy. Sports data is messy enough to require real cleaning and transformation, which made it good practice for writing SQL, creating reusable views, and building a dashboard that answers meaningful questions instead of simply displaying charts.
