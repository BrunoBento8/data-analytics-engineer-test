WITH raw_Team_Attributes AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'Team_Attributes') }}
)

SELECT 
    CAST(JSON_extract(Team_Attributes, '$.id') AS INT) as id
    , CAST(JSON_extract(Team_Attributes, '$.team_fifa_api_id') AS INT) as team_fifa_api_id
    , CAST(JSON_extract(Team_Attributes, '$.team_api_id') AS INT) as team_api_id
    , JSON_extract(Team_Attributes, '$.date') as date
    , CAST(JSON_extract(Team_Attributes, '$.buildUpPlaySpeed') AS INT) as buildUpPlaySpeed
    , JSON_extract(Team_Attributes, '$.buildUpPlaySpeedClass') as buildUpPlaySpeedClass
    , CAST(JSON_extract(Team_Attributes, '$.buildUpPlayDribbling') AS FLOAT) as buildUpPlayDribbling
    , JSON_extract(Team_Attributes, '$.buildUpPlayDribblingClass') as buildUpPlayDribblingClass
    , CAST(JSON_extract(Team_Attributes, '$.buildUpPlayPassing') AS INT) as buildUpPlayPassing
    , JSON_extract(Team_Attributes, '$.buildUpPlayPassingClass') as buildUpPlayPassingClass
    , JSON_extract(Team_Attributes, '$.buildUpPlayPositioningClass') as buildUpPlayPositioningClass
    , CAST(JSON_extract(Team_Attributes, '$.chanceCreationPassing') AS INT) as chanceCreationPassing
    , JSON_extract(Team_Attributes, '$.chanceCreationPassingClass') as chanceCreationPassingClass
    , CAST(JSON_extract(Team_Attributes, '$.chanceCreationCrossing') AS INT) as chanceCreationCrossing
    , JSON_extract(Team_Attributes, '$.chanceCreationCrossingClass') as chanceCreationCrossingClass
    , CAST(JSON_extract(Team_Attributes, '$.chanceCreationShooting') AS INT) as chanceCreationShooting
    , JSON_extract(Team_Attributes, '$.chanceCreationShootingClass') as chanceCreationShootingClass
    , JSON_extract(Team_Attributes, '$.chanceCreationPositioningClass') as chanceCreationPositioningClass
    , CAST(JSON_extract(Team_Attributes, '$.defencePressure') AS INT) as defencePressure
    , JSON_extract(Team_Attributes, '$.defencePressureClass') as defencePressureClass
    , CAST(JSON_extract(Team_Attributes, '$.defenceAggression') AS INT) as defenceAggression
    , JSON_extract(Team_Attributes, '$.defenceAggressionClass') as defenceAggressionClass
    , CAST(JSON_extract(Team_Attributes, '$.defenceTeamWidth') AS INT) as defenceTeamWidth
    , JSON_extract(Team_Attributes, '$.defenceTeamWidthClass') as defenceTeamWidthClass
    , JSON_extract(Team_Attributes, '$.defenceDefenderLineClass') as defenceDefenderLineClass
FROM raw_Team_Attributes