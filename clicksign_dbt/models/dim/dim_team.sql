{{ config(materialized = 'table') }}

WITH src_team_attributes AS (
    SELECT
    *
    , ROW_NUMBER() OVER (PARTITION BY team_api_id ORDER BY ID) AS CONTADOR
    FROM
    {{ ref('src_team_attributes') }}
)
, src_team AS (
    SELECT
    *
    FROM
    {{ ref('src_team') }}
)

SELECT
	a.*
	, b.team_long_name
    , b.team_short_name
FROM src_player_attributes a
LEFT JOIN src_player b
    ON b.team_api_id =  a.team_api_id
WHERE CONTADOR = 1 -- Último atributo coletado do time