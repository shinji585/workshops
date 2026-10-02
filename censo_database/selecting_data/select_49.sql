-- #46
-- Count people between 25 and 35 years old who reside in a specific municipality.
WITH personas_municipio AS (
    SELECT CONCAT_WS(
            ' ',
            p.first_name,
            p.second_name,
            p.last_name1,
            p.last_name2
        ) AS full_name,
        p.id,
        get_age(p.date_of_birth) AS age
    FROM persona p
        INNER JOIN registro_hecho rh ON p.id = rh.id_persona
        INNER JOIN hogar_hecho hh ON rh.id_hogar_hecho = hh.id
        INNER JOIN manzana ma ON hh.id_manzana = ma.id
        INNER JOIN distrito di ON ma.id_distrito = di.id
        INNER JOIN municipio mu ON di.id_municipio = mu.id
    WHERE mu.name ILIKE 'Cartagena de Indias'
)
SELECT COUNT(DISTINCT id) AS person_count,
    STRING_AGG(
        DISTINCT full_name,
        ', '
        ORDER BY full_name
    ) AS personas
FROM personas_municipio
WHERE age BETWEEN 25 AND 35;