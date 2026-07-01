-- 1. Which draft ranges produce the most value?

SELECT
    pick_range,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player'))::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY pick_range
ORDER BY avg_point_shares DESC;


-- 2. Which teams drafted the best overall?

SELECT *
FROM vw_team_draft_performance
ORDER BY success_rate DESC;


-- 3. Which nationalities produced the strongest draft results?

SELECT *
FROM vw_nationality_performance
ORDER BY avg_point_shares DESC;


-- 4. Which positions produced the most value?

SELECT *
FROM vw_position_performance
ORDER BY avg_point_shares DESC;


-- 5. Biggest draft steals

SELECT *
FROM vw_draft_steals
LIMIT 25;


-- 6. Biggest top-10 busts

SELECT *
FROM vw_draft_busts
LIMIT 25;


-- 7. Best players drafted by point shares

SELECT
    player,
    year,
    team,
    overall_pick,
    pick_range,
    nationality,
    position,
    games_played,
    points,
    point_shares,
    career_tier
FROM nhl_draft
ORDER BY point_shares DESC
LIMIT 25;


-- 8. Career tier breakdown

SELECT
    career_tier,
    COUNT(*) AS player_count,
    ROUND(COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER (), 3) AS percentage_of_players
FROM nhl_draft
GROUP BY career_tier
ORDER BY
    CASE career_tier
        WHEN 'Elite' THEN 1
        WHEN 'Star' THEN 2
        WHEN 'Solid NHL Player' THEN 3
        WHEN 'Role Player' THEN 4
        WHEN 'Brief NHL Career' THEN 5
        WHEN 'Never Played' THEN 6
        ELSE 7
    END;


-- 9. Draft performance by era

SELECT
    draft_era,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players
FROM nhl_draft
GROUP BY draft_era
ORDER BY MIN(year);


-- 10. Best goalies drafted

SELECT *
FROM vw_goalie_performance
WHERE goalie_games_played > 100
ORDER BY point_shares DESC
LIMIT 25;


-- 11. Best late-round picks by team

SELECT
    team,
    COUNT(*) AS late_picks,
    COUNT(*) FILTER (WHERE point_shares >= 20) AS successful_late_picks,
    ROUND(AVG(point_shares), 2) AS avg_late_pick_point_shares
FROM nhl_draft
WHERE overall_pick > 100
GROUP BY team
HAVING COUNT(*) >= 10
ORDER BY successful_late_picks DESC, avg_late_pick_point_shares DESC;


-- 12. Draft value by pick range and era

SELECT
    draft_era,
    pick_range,
    COUNT(*) AS players_drafted,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players
FROM nhl_draft
GROUP BY draft_era, pick_range
ORDER BY draft_era, avg_point_shares DESC;