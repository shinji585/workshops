WITH lugares_extranjeros AS (
    SELECT l.id AS id_lugar_universal, c.name AS city_name, c.id_pais
    FROM lugar_universal l  
    INNER JOIN ciudad_extranjera c ON l.id_ciudad_extranjera = c.id  
)
SELECT 
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    p.occupation,
    le.city_name AS city_name_born,
    ps.name AS country_name
FROM persona p 
INNER JOIN lugares_extranjeros le ON p.id_lugar_nacimiento = le.id_lugar_universal
INNER JOIN pais ps ON ps.id = le.id_pais;