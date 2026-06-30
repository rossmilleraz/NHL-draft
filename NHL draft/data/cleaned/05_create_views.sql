CREATE OR REPLACE VIEW vw_tableau_main AS
SELECT
    id,
    year,
    draft_era,
    overall_pick,
    pick_range,
    team,
    player,
    nationality,
    position,
    player_type,
    age,
    to_year,
    amateur_team,
    games_played,
    goals,
    assists,
    points,
    plus_minus,
    penalties_minutes,
    goalie_games_played,
    goalie_wins,
    goalie_losses,
    goalie_ties_overtime,
    save_percentage,
    goals_against_average,
    point_shares,
    points_per_game,
    career_tier
FROM nhl_draft;

CREATE OR REPLACE VIEW vw_draft_pick_value AS
SELECT
    overall_pick,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players
FROM nhl_draft
GROUP BY overall_pick
ORDER BY overall_pick;

CREATE OR REPLACE VIEW vw_team_draft_performance AS
SELECT
    team,
    COUNT(*) AS players_drafted,
    ROUND(AVG(overall_pick), 1) AS avg_draft_position,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player'))::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY team
HAVING COUNT(*) >= 20
ORDER BY success_rate DESC;

CREATE OR REPLACE VIEW vw_nationality_performance AS
SELECT
    nationality,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players,
    ROUND(
        COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player'))::NUMERIC / COUNT(*),
        3
    ) AS success_rate
FROM nhl_draft
GROUP BY nationality
HAVING COUNT(*) >= 20
ORDER BY avg_point_shares DESC;

CREATE OR REPLACE VIEW vw_position_performance AS
SELECT
    position,
    player_type,
    COUNT(*) AS players_drafted,
    ROUND(AVG(games_played), 1) AS avg_games_played,
    ROUND(AVG(points), 1) AS avg_points,
    ROUND(AVG(point_shares), 2) AS avg_point_shares,
    COUNT(*) FILTER (WHERE career_tier = 'Elite') AS elite_players,
    COUNT(*) FILTER (WHERE career_tier IN ('Elite', 'Star', 'Solid NHL Player')) AS successful_players
FROM nhl_draft
GROUP BY position, player_type
ORDER BY avg_point_shares DESC;

CREATE OR REPLACE VIEW vw_draft_steals AS
SELECT
    player,
    year,
    draft_era,
    team,
    overall_pick,
    pick_range,
    nationality,
    position,
    player_type,
    games_played,
    points,
    point_shares,
    career_tier
FROM nhl_draft
WHERE overall_pick > 100
  AND point_shares >= 20
ORDER BY point_shares DESC;

CREATE OR REPLACE VIEW vw_draft_busts AS
SELECT
    player,
    year,
    draft_era,
    team,
    overall_pick,
    pick_range,
    nationality,
    position,
    player_type,
    games_played,
    points,
    point_shares,
    career_tier
FROM nhl_draft
WHERE overall_pick <= 10
  AND point_shares < 5
ORDER BY overall_pick ASC;

CREATE OR REPLACE VIEW vw_goalie_performance AS
SELECT
    player,
    year,
    team,
    overall_pick,
    pick_range,
    nationality,
    goalie_games_played,
    goalie_wins,
    goalie_losses,
    save_percentage,
    goals_against_average,
    point_shares,
    career_tier
FROM nhl_draft
WHERE position = 'G'
ORDER BY point_shares DESC;