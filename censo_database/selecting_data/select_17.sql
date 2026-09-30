WITH order_universal_place AS (
    SELECT
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
        lu.id_municipio_colombia
    FROM persona p 
    INNER JOIN lugar_universal lu ON p.id_lugar_nacimiento = lu.id
)
SELECT 
    ord.full_name,
    de.name
FROM order_universal_place ord 
INNER JOIN municipio mu ON ord.id_municipio_colombia = mu.id
INNER JOIN departamento de ON mu.id_departamento = de.id;