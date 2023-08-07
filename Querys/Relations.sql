CREATE TABLE Relations as
-- Na análise exploratória foi detectada presença de valores dublicados de ID, a ideia é limpar estes valores para atribuir relação coma as outras tabelas
WITH country_count as (
    SELECT 
         id
        , name as country_name
        , ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) as CONTADOR -- Detectar duplicados
    FROM Country
)

-- Seleciona apenas os dados de jogadores que jogaram em casa e foram escalados
, home_player as (
    SELECT DISTINCT
        country_id
        , league_id
        , player_api_id
        , player_name
        , home_team_api_id
    FROM Player a
    LEFT JOIN Match b
        ON a.player_api_id = b.home_player_1
)

-- Relação entre as tabelas: Country, League, Home_player, Player e Team_Attributes_Modified 
SELECT distinct
    a.Country_id
    , country_name
    , a.id as id_league
    , name as league_name
    , league_id
    , c.player_api_id
    , c.player_name
    , player_fifa_api_id
    , birthday
    , height
    , weight
    , team_api_id
    , team_fifa_api_id
    , team_long_name
    , team_short_name        
FROM League a
LEFT JOIN country_count b
    ON a.country_id = b.id 
LEFT JOIN home_player c
    ON c.league_id = a.id
LEFT JOIN Player d
    ON  d.player_api_id = c.player_api_id
LEFT JOIN Team_Attributes_Modified e
    ON e.team_api_id = c.home_team_api_id
WHERE
    b.CONTADOR = 1 -- Limpeza de ID's publicados
    OR b.id IS NULL --  ID's fora da tabela Country