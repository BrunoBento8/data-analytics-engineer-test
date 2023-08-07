WITH raw_Country AS (
    SELECT
    *
    FROM
    {{ source('test_analytics_engineer.db', 'Country') }}
)

SELECT 
    id
    , name
FROM raw_Country