-- Creates the aggregated draft range view used in the dashboard.

CREATE OR REPLACE VIEW vw_pick_range_value AS

SELECT
    pick_range,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played),1) AS avg_games_played,
    ROUND(AVG(points),1) AS avg_points,
    ROUND(AVG(point_shares),2) AS avg_point_shares,
    COUNT(*) FILTER (
        WHERE career_tier IN ('Elite','Star','Solid NHL Player')
    ) AS successful_players,
    ROUND(
        COUNT(*) FILTER (
            WHERE career_tier IN ('Elite','Star','Solid NHL Player')
        )::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY pick_range
ORDER BY
CASE pick_range
    WHEN 'Top 10' THEN 1
    WHEN 'Rest of Round 1' THEN 2
    WHEN 'Round 2' THEN 3
    WHEN 'Round 3' THEN 4
    WHEN 'Round 4' THEN 5
    ELSE 6
END;