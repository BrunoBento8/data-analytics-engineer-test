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
    {{ dbt_utils.generate_surrogate_key(['id','country_id','league_id','season','stage','date','match_api_id']) }} as id_match
    , a.*
FROM src_match
{% if is_incremental() %}
  AND date > (select max(date) from {{ this }})
{% endif %}