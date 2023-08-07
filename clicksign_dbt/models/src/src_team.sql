WITH raw_team AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'Team') }}
)

SELECT 
    id
    , team_api_id
    , team_fifa_api_id
    , team_long_name
    , team_short_name
FROM raw_team