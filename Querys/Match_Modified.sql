CREATE TABLE Match_Modified AS 
SELECT    
    ROW_NUMBER() OVER( ORDER BY id) - 1 AS id -- Seguindo o padrão de iniciar em zero.
    , json_object(
                'id', CAST(id AS TEXT)
                ,'match_api_id' , CAST(match_api_id AS TEXT)
                ,'home_team_api_id', CAST(home_team_api_id AS TEXT)
                ,'away_team_api_id', CAST(away_team_api_id AS TEXT)
                ) 
     AS COLUNAS_JSON
FROM Match