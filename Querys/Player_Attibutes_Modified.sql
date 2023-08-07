CREATE TABLE Player_Attributes_Modified AS
WITH Player_Attribute AS (
	SELECT
		CAST(JSON_extract(player_attributes, '$.id') AS INT) as id
		, CAST(JSON_extract(player_attributes, '$.player_fifa_api_id') AS INT) as player_fifa_api_id
		, CAST(JSON_extract(player_attributes, '$.player_api_id') AS INT) as player_api_id
		, JSON_extract(player_attributes, '$.date') as date
		, CAST(JSON_extract(player_attributes, '$.overall_rating') AS FLOAT) as overall_rating
		, CAST(JSON_extract(player_attributes, '$.potential') AS FLOAT) as potential
		, JSON_extract(player_attributes, '$.preferred_foot') as preferred_foot
		, JSON_extract(player_attributes, '$.attacking_work_rate') as attacking_work_rate
		, JSON_extract(player_attributes, '$.defensive_work_rate') as defensive_work_rate
		, CAST(JSON_extract(player_attributes, '$.crossing') AS FLOAT) as crossing
		, CAST(JSON_extract(player_attributes, '$.finishing') AS FLOAT) as finishing
		, CAST(JSON_extract(player_attributes, '$.heading_accuracy') AS FLOAT) as heading_accuracy
		, CAST(JSON_extract(player_attributes, '$.short_passing') AS FLOAT) as short_passing
		, CAST(JSON_extract(player_attributes, '$.volleys') AS FLOAT) as volleys
		, CAST(JSON_extract(player_attributes, '$.dribbling') AS FLOAT) as dribbling
		, CAST(JSON_extract(player_attributes, '$.curve') AS FLOAT) as curve
		, CAST(JSON_extract(player_attributes, '$.free_kick_accuracy') AS FLOAT) as free_kick_accuracy
		, CAST(JSON_extract(player_attributes, '$.long_passing') AS FLOAT) as long_passing
		, CAST(JSON_extract(player_attributes, '$.ball_control') AS FLOAT) as ball_control
		, CAST(JSON_extract(player_attributes, '$.acceleration') AS FLOAT) as acceleration
		, CAST(JSON_extract(player_attributes, '$.sprint_speed') AS FLOAT) as sprint_speed
		, CAST(JSON_extract(player_attributes, '$.agility') AS FLOAT) as agility
		, CAST(JSON_extract(player_attributes, '$.reactions') AS FLOAT) as reactions
		, CAST(JSON_extract(player_attributes, '$.balance') AS FLOAT) as balance
		, CAST(JSON_extract(player_attributes, '$.shot_power') AS FLOAT) as shot_power
		, CAST(JSON_extract(player_attributes, '$.jumping') AS FLOAT) as jumping
		, CAST(JSON_extract(player_attributes, '$.stamina') AS FLOAT) as stamina
		, CAST(JSON_extract(player_attributes, '$.strength') AS FLOAT) as strength
		, CAST(JSON_extract(player_attributes, '$.long_shots') AS FLOAT) as long_shots
		, CAST(JSON_extract(player_attributes, '$.aggression') AS FLOAT) as aggression
		, CAST(JSON_extract(player_attributes, '$.interceptions') AS FLOAT) as interceptions
		, CAST(JSON_extract(player_attributes, '$.positioning') AS FLOAT) as positioning
		, CAST(JSON_extract(player_attributes, '$.vision') AS FLOAT) as vision
		, CAST(JSON_extract(player_attributes, '$.penalties') AS FLOAT) as penalties
		, CAST(JSON_extract(player_attributes, '$.marking') AS FLOAT) as marking
		, CAST(JSON_extract(player_attributes, '$.standing_tackle') AS FLOAT) as standing_tackle
		, CAST(JSON_extract(player_attributes, '$.sliding_tackle') AS FLOAT) as sliding_tackle
		, CAST(JSON_extract(player_attributes, '$.gk_diving') AS FLOAT) as gk_diving
		, CAST(JSON_extract(player_attributes, '$.gk_handling') AS FLOAT) as gk_handling
		, CAST(JSON_extract(player_attributes, '$.gk_kicking') AS FLOAT) as gk_kicking
		, CAST(JSON_extract(player_attributes, '$.gk_positioning') AS FLOAT) as gk_positioning
		, CAST(JSON_extract(player_attributes, '$.gk_reflexes') AS FLOAT) as gk_reflexes
	FROM Player_Attributes
)
SELECT 
	a.*
	, b.player_name
    , b.birthday
    , b.height
    , b.weight
FROM Player_Attribute a
LEFT JOIN Player b
    ON a.player_fifa_api_id = b.player_fifa_api_id