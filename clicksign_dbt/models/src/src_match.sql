WITH raw_match AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'Match') }}
)

SELECT 
	id	
	, country_id
	, season	
	, stage	
	, date	
	, match_api_id	
	, home_team_api_id	
	, away_team_api_id	
	, home_team_goal	
	, away_team_goal
	, home_player_1
	, B365H,B365D,B365A,BWH,BWD,BWA,IWH,IWD,IWA,LBH,LBD,LBA,PSH,PSD,PSA,WHH,WHD,WHA,SJH,SJD,SJA,VCH,VCD,VCA,GBH,GBD,GBA,BSH,BSD,BSA
FROM raw_match