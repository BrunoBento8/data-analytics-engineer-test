WITH raw_League AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'League') }}
)

SELECT 
    id
    , country_id
    , name
FROM raw_League