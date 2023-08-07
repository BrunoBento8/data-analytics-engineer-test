{{ config(materialized = 'table') }}

WITH src_country AS (
    SELECT
    *
	, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) as CONTADOR -- Detectar duplicados
    FROM
    {{ ref('src_country') }}
)
, src_league AS (
    SELECT
    *
    FROM
    {{ ref('src_league') }}
)

SELECT 
    a.id
    , a.name as country_name
    , b.name as league_name
FROM src_country a
LEFT JOIN src_league b
    ON a.id = b.id_country
WHERE
    a.CONTADOR = 1 -- Limpeza de ID's publicados
    OR a.id IS NOT NULL 