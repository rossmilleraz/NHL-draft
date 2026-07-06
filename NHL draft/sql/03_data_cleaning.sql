-- Cleans and standardizes the raw data for analysis.

-- Clean text columns
UPDATE nhl_draft
SET
    team = TRIM(team),
    player = TRIM(player),
    nationality = TRIM(nationality),
    position = UPPER(TRIM(position)),
    amateur_team = TRIM(amateur_team);

-- Replace missing career stats with 0
UPDATE nhl_draft
SET
    games_played = COALESCE(games_played, 0),
    goals = COALESCE(goals, 0),
    assists = COALESCE(assists, 0),
    points = COALESCE(points, 0),
    penalties_minutes = COALESCE(penalties_minutes, 0),
    point_shares = COALESCE(point_shares, 0);

-- Replace missing goalie counting stats with 0
UPDATE nhl_draft
SET
    goalie_games_played = COALESCE(goalie_games_played, 0),
    goalie_wins = COALESCE(goalie_wins, 0),
    goalie_losses = COALESCE(goalie_losses, 0),
    goalie_ties_overtime = COALESCE(goalie_ties_overtime, 0);

-- Keep save_percentage and goals_against_average NULL for non-goalies.
-- They are not applicable, so 0 would be misleading.

-- Standardize nationality names if they appear
UPDATE nhl_draft
SET nationality = 'United States'
WHERE nationality IN ('USA', 'US', 'U.S.A.', 'United States of America');

UPDATE nhl_draft
SET nationality = 'Czech Republic'
WHERE nationality IN ('Czechia', 'CZE');

-- Verify cleaned data
SELECT *
FROM nhl_draft
LIMIT 20;