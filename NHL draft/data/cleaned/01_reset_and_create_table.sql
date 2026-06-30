DROP VIEW IF EXISTS vw_draft_pick_value;
DROP VIEW IF EXISTS vw_team_draft_performance;
DROP VIEW IF EXISTS vw_nationality_performance;
DROP VIEW IF EXISTS vw_position_performance;
DROP VIEW IF EXISTS vw_draft_steals;
DROP VIEW IF EXISTS vw_draft_busts;
DROP VIEW IF EXISTS vw_goalie_performance;
DROP VIEW IF EXISTS vw_tableau_main;

DROP TABLE IF EXISTS nhl_draft;

CREATE TABLE nhl_draft (
    id INTEGER PRIMARY KEY,
    year INTEGER,
    overall_pick INTEGER,
    team VARCHAR(50),
    player VARCHAR(100),
    nationality VARCHAR(50),
    position VARCHAR(10),
    age NUMERIC(4,1),
    to_year INTEGER,
    amateur_team VARCHAR(150),
    games_played INTEGER,
    goals INTEGER,
    assists INTEGER,
    points INTEGER,
    plus_minus INTEGER,
    penalties_minutes INTEGER,
    goalie_games_played INTEGER,
    goalie_wins INTEGER,
    goalie_losses INTEGER,
    goalie_ties_overtime INTEGER,
    save_percentage NUMERIC(5,3),
    goals_against_average NUMERIC(5,2),
    point_shares NUMERIC(7,2)
);