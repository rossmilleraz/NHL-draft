-- Additional views created specifically for Tableau visualizations.

-- 1. Career tier distribution
CREATE OR REPLACE VIEW vw_career_tier_distribution AS
SELECT
    career_tier,
    COUNT(*) AS player_count,
    ROUND(COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER (), 3) AS player_percentage
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


-- 2. Draft success by era
CREATE OR REPLACE VIEW vw_draft_success_by_era AS
SELECT
    draft_era,
    COUNT(*) AS players_drafted,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player'))::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY draft_era
ORDER BY MIN(year);


-- 3. Success by pick range and position
CREATE OR REPLACE VIEW vw_pick_range_position_success AS
SELECT
    pick_range,
    position,
    player_type,
    COUNT(*) AS players_drafted,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player'))::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY pick_range, position, player_type
ORDER BY pick_range, success_rate DESC;


-- 4. Elite player rate by nationality
CREATE OR REPLACE VIEW vw_elite_rate_by_nationality AS
SELECT
    nationality,
    COUNT(*) AS players_drafted,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier = 'Elite')::NUMERIC / COUNT(*),
        3
    ) AS elite_rate,
    ROUND(AVG(point_shares), 2) AS avg_point_shares
FROM nhl_draft
GROUP BY nationality
HAVING COUNT(*) >= 20
ORDER BY elite_rate DESC;


-- 5. Team late-round value
CREATE OR REPLACE VIEW vw_team_late_round_value AS
SELECT
    team,
    COUNT(*) AS late_round_picks,
    COUNT(*) FILTER (WHERE point_shares >= 20) AS successful_late_picks,
    ROUND(AVG(point_shares), 2) AS avg_late_pick_point_shares,
    ROUND(
        COUNT(*) FILTER (WHERE point_shares >= 20)::NUMERIC / COUNT(*),
        3
    ) AS late_pick_success_rate
FROM nhl_draft
WHERE overall_pick > 100
GROUP BY team
HAVING COUNT(*) >= 10
ORDER BY late_pick_success_rate DESC;


-- 6. Draft pick efficiency by team
CREATE OR REPLACE VIEW vw_team_pick_efficiency AS
SELECT
    team,
    COUNT(*) AS players_drafted,
    ROUND(AVG(overall_pick), 1) AS avg_pick_number,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    ROUND(AVG(point_shares / NULLIF(overall_pick, 0)), 4) AS value_per_pick
FROM nhl_draft
GROUP BY team
HAVING COUNT(*) >= 20
ORDER BY value_per_pick DESC;


-- 7. Tableau KPI summary
CREATE OR REPLACE VIEW vw_dashboard_kpis AS
SELECT
    COUNT(*) AS total_players,
    COUNT(DISTINCT team) AS total_teams,
    COUNT(DISTINCT nationality) AS total_nationalities,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players
FROM nhl_draft;