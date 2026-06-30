ALTER TABLE nhl_draft
ADD COLUMN IF NOT EXISTS career_tier VARCHAR(30);

UPDATE nhl_draft
SET career_tier =
    CASE
        WHEN point_shares >= 100 THEN 'Elite'
        WHEN point_shares >= 50 THEN 'Star'
        WHEN point_shares >= 20 THEN 'Solid NHL Player'
        WHEN point_shares >= 5 THEN 'Role Player'
        WHEN games_played > 0 THEN 'Brief NHL Career'
        ELSE 'Never Played'
    END;

ALTER TABLE nhl_draft
ADD COLUMN IF NOT EXISTS pick_range VARCHAR(20);

UPDATE nhl_draft
SET pick_range =
    CASE
        WHEN overall_pick <= 10 THEN 'Top 10'
        WHEN overall_pick <= 32 THEN 'Rest of Round 1'
        WHEN overall_pick <= 64 THEN 'Round 2'
        WHEN overall_pick <= 96 THEN 'Round 3'
        WHEN overall_pick <= 128 THEN 'Round 4'
        ELSE 'Round 5+'
    END;

ALTER TABLE nhl_draft
ADD COLUMN IF NOT EXISTS player_type VARCHAR(20);

UPDATE nhl_draft
SET player_type =
    CASE
        WHEN position = 'G' THEN 'Goalie'
        ELSE 'Skater'
    END;

ALTER TABLE nhl_draft
ADD COLUMN IF NOT EXISTS points_per_game NUMERIC(6,3);

UPDATE nhl_draft
SET points_per_game =
    CASE
        WHEN games_played > 0 THEN ROUND(points::NUMERIC / games_played, 3)
        ELSE 0
    END;

ALTER TABLE nhl_draft
ADD COLUMN IF NOT EXISTS draft_era VARCHAR(30);

UPDATE nhl_draft
SET draft_era =
    CASE
        WHEN year < 1980 THEN 'Pre-1980'
        WHEN year BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN year BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN year BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN year BETWEEN 2010 AND 2019 THEN '2010s'
        ELSE '2020s'
    END;

-- Check results
SELECT
    career_tier,
    COUNT(*) AS player_count
FROM nhl_draft
GROUP BY career_tier
ORDER BY player_count DESC;