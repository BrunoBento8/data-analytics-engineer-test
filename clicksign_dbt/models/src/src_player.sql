WITH raw_Player AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'Player') }}
)

SELECT 
    id	
    , player_api_id	
    , player_name
    , player_fifa_api_id
	, player_name
    , birthday
    , height
    , weight
FROM raw_Player