-- Initial exploration of the dataset to identify missing values, duplicates, and overall data quality.

-- Total rows
SELECT COUNT(*) AS total_rows
FROM nhl_draft;

-- Preview data
SELECT *
FROM nhl_draft
LIMIT 20;

-- Draft year range
SELECT
    MIN(year) AS earliest_year,
    MAX(year) AS latest_year
FROM nhl_draft;

-- Duplicate IDs
SELECT
    id,
    COUNT(*) AS duplicate_count
FROM nhl_draft
GROUP BY id
HAVING COUNT(*) > 1;

-- Duplicate player/year combinations
SELECT
    player,
    year,
    COUNT(*) AS duplicate_count
FROM nhl_draft
GROUP BY player, year
HAVING COUNT(*) > 1;

-- Missing values
SELECT
    COUNT(*) FILTER (WHERE team IS NULL) AS team_nulls,
    COUNT(*) FILTER (WHERE player IS NULL) AS player_nulls,
    COUNT(*) FILTER (WHERE nationality IS NULL) AS nationality_nulls,
    COUNT(*) FILTER (WHERE position IS NULL) AS position_nulls,
    COUNT(*) FILTER (WHERE age IS NULL) AS age_nulls,
    COUNT(*) FILTER (WHERE amateur_team IS NULL) AS amateur_team_nulls,
    COUNT(*) FILTER (WHERE games_played IS NULL) AS games_played_nulls,
    COUNT(*) FILTER (WHERE goals IS NULL) AS goals_nulls,
    COUNT(*) FILTER (WHERE assists IS NULL) AS assists_nulls,
    COUNT(*) FILTER (WHERE points IS NULL) AS points_nulls,
    COUNT(*) FILTER (WHERE plus_minus IS NULL) AS plus_minus_nulls,
    COUNT(*) FILTER (WHERE penalties_minutes IS NULL) AS penalties_minutes_nulls,
    COUNT(*) FILTER (WHERE point_shares IS NULL) AS point_shares_nulls
FROM nhl_draft;

-- Goalie stat missing values
SELECT
    COUNT(*) FILTER (WHERE goalie_games_played IS NULL) AS goalie_games_played_nulls,
    COUNT(*) FILTER (WHERE goalie_wins IS NULL) AS goalie_wins_nulls,
    COUNT(*) FILTER (WHERE goalie_losses IS NULL) AS goalie_losses_nulls,
    COUNT(*) FILTER (WHERE goalie_ties_overtime IS NULL) AS goalie_ties_overtime_nulls,
    COUNT(*) FILTER (WHERE save_percentage IS NULL) AS save_percentage_nulls,
    COUNT(*) FILTER (WHERE goals_against_average IS NULL) AS goals_against_average_nulls
FROM nhl_draft;

-- Positions
SELECT
    position,
    COUNT(*) AS player_count
FROM nhl_draft
GROUP BY position
ORDER BY player_count DESC;

-- Nationalities
SELECT
    nationality,
    COUNT(*) AS player_count
FROM nhl_draft
GROUP BY nationality
ORDER BY player_count DESC;

-- Teams
SELECT
    team,
    COUNT(*) AS player_count
FROM nhl_draft
GROUP BY team
ORDER BY team;

-- Age range
SELECT
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM nhl_draft;

-- Pick range
SELECT
    MIN(overall_pick) AS lowest_pick,
    MAX(overall_pick) AS highest_pick
FROM nhl_draft;

-- Negative values
SELECT *
FROM nhl_draft
WHERE games_played < 0
   OR goals < 0
   OR assists < 0
   OR points < 0
   OR penalties_minutes < 0;