/*Proporção entre destros e canhotos*/
SELECT
    count(distinct player_api_id) as count_players
    , preferred_foot 
FROM Player_Attributes_Modified
where preferred_foot not like '0' -- Limpeza de sujeiras encontradas
group by preferred_foot 

/*Lista dos jogadores e qual o pé que eles chutam*/
SELECT
    player_api_id
    , player_name
    , preferred_foot 
FROM Player_Attributes_Modified
where preferred_foot not like '0' -- Limpeza de sujeiras encontradas
group by 
    player_api_id
    , player_name
    , preferred_foot 

/* Lista de jogadores que chutam com os dois pés*/ 
SELECT
    count(distinct preferred_foot) as count_preferred_foot
    , player_name 
FROM Player_Attributes_Modified
where preferred_foot not like '0' -- Limpeza de sujeiras encontradas
group by player_name
having count(distinct preferred_foot) > 1 -- Seleciona os jogadores que chutam com mais de 1 pé
order by 2


/* Numero de jogadores que chutam com os dois pés*/
WITH player_kick as (
    SELECT
        count(distinct preferred_foot) as count_preferred_foot
        , player_name 
    FROM Player_Attributes_Modified
    where preferred_foot not like '0' -- Limpeza de sujeiras encontradas
    group by player_name
    having count(distinct preferred_foot) > 1 -- Seleciona os jogadores que chutam com mais de 1 pé
)

SELECT
    count(player_name) as count_player_kick_both_feet
from player_kick


/* País com maior número de gols */
with country_count as (
    SELECT 
        id
        , name
        , ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as CONTADOR -- Detectar duplicados
    FROM Country
)


, gols as (
    SELECT
        country_count.id
        , name
        , home_team_goal
        , away_team_goal
    FROM country_count
    LEFT JOIN Match
        ON country_count.id = Match.country_id
    WHERE
        country_count.id is not null 
        and country_count.id <> 0 
         and CONTADOR = 1 -- Limpeza de ID's publicados
) 

-- Seleciona com base na tabela anterior o páis com maior número de gols.

SELECT 
    id
    , name
    , max(number_gols) as max_gols
FROM (
	SELECT 
        id
        , name
        , sum(home_team_goal+away_team_goal) as number_gols
    FROM gols
    GROUP BY id, name
)

       

/* Times com maior saldos de Gols */
with Teams as (
    SELECT 
        team_api_id
        , team_long_name       
    FROM Team
)

-- Gols em casa
, gols_home as (
    SELECT
        home_team_api_id
        , home_team_goal
    FROM Match
) 
-- Gols fora de casa
, gols_away as (
    SELECT
        away_team_api_id
        , away_team_goal
    FROM Match
) 

SELECT
    team_api_id
    , team_long_name
    , SUM(home_team_goal) home_gols
    , SUM(away_team_goal) away_gols
    , SUM(home_team_goal-away_team_goal) gols_dirference 
FROM Teams a
LEFT JOIN gols_home b
    ON a.team_api_id = b.home_team_api_id
LEFT JOIN gols_away c
    ON a.team_api_id = c.away_team_api_id
GROUP BY team_api_id
    , team_long_name
ORDER BY SUM(home_team_goal-away_team_goal) DESC


/* Países que não estão na tabela Country */
WITH country_count as (
    SELECT 
         id
        , name as country_name
        , ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) as CONTADOR -- Detectar duplicados
    FROM Country
)

, joined as (
    SELECT 
        Country_id
        , country_name
    FROM League
    LEFT JOIN country_count
        ON League.country_id = country_count.id
    WHERE
        CONTADOR = 1 -- Limpeza de ID's publicados
        OR country_count.id IS NULL 
)
SELECT * 
FROM joined
WHERE country_name IS NULL