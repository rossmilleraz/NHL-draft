-- Exports the final views used as Tableau data sources.

DROP VIEW IF EXISTS vw_dashboard;

CREATE VIEW vw_dashboard AS

SELECT

    year,

    draft_era,

    overall_pick,

    pick_range,

    team,

    player,

    nationality,

    position,

    player_type,

    career_tier,

    games_played,

    goals,

    assists,

    points,

    point_shares,

    points_per_game,

    goalie_games_played,

    goalie_wins,

    goalie_losses,

    save_percentage,

    goals_against_average

FROM nhl_draft;