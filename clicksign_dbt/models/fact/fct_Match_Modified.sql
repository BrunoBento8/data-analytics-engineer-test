-- A mesma ideia da Match_Modified, porém com carga incremental.

{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}

WITH src_match AS (
    SELECT
    *
    FROM
    {{ ref('src_match') }}
)

SELECT    
    ROW_NUMBER() OVER( ORDER BY id) - 1 AS id
    , json_object(
                'id', CAST(id AS TEXT)
                ,'match_api_id' , CAST(match_api_id AS TEXT)
                ,'home_team_api_id', CAST(home_team_api_id AS TEXT)
                ,'away_team_api_id', CAST(away_team_api_id AS TEXT)
                ) 
     AS COLUNAS_JSON
FROM src_match
{% if is_incremental() %}
  AND ID > (select max(ID) from {{ this }})
{% endif %}