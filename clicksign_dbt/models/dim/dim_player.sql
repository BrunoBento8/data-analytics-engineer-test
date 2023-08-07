{{ config(materialized = 'table') }}

WITH src_player_attributes AS (
    SELECT
    *
    , ROW_NUMBER() OVER (PARTITION BY player_api_id ORDER BY ID) AS CONTADOR
    FROM
    {{ ref('src_player_attributes') }}
)
, src_player AS (
    SELECT
    *
    FROM
    {{ ref('src_player') }}
)

SELECT
	a.*
	, b.player_name
    , b.birthday
    , b.height
    , b.weight
FROM src_player_attributes a
LEFT JOIN src_player b
    ON a.player_fifa_api_id = b.player_fifa_api_id
WHERE CONTADOR = 1 -- Último atributo coletado do jogador