with times as (
    SELECT 
        team_api_id
        , team_long_name       
    FROM {{ ref('src_team') }}
)

, gols_casa as (
    SELECT
        home_team_api_id
        , sum(home_team_goal) as sum_home_goals 
        , avg(home_team_goal) as average_home_gols
        , season
    FROM {{ ref('src_match') }}
    GROUP BY
        home_team_api_id
        , season
) 

, gols_fora as (
    SELECT
        away_team_api_id
        , sum(away_team_goal) as sum_away_goals
        , avg(away_team_goal) as average_away_gols
        , season
    FROM {{ ref('src_match') }}
    GROUP BY
        away_team_api_id
        , season
        
) 

SELECT
   team_api_id
    , team_long_name
    , sum_home_goals
    , sum_away_goals
    , average_home_gols
    , average_away_gols
    , b.season
FROM times a
LEFT JOIN gols_casa b
    ON a.team_api_id = b.home_team_api_id
LEFT JOIN gols_fora c
    ON b.home_team_api_id = c.away_team_api_id
    and  b.season = c.season  
ORDER BY sum_home_goals DESC, team_long_name, b.season