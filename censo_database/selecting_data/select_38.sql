-- #20
-- Select all people who changed their address during the last year.
SELECT p.*
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
WHERE rh.start_date >= CURRENT_DATE - INTERVAL '1 year';


-- #21
-- Find the tallest person in a specific municipality.
WITH personas_municipio AS (
    SELECT
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
        p.height,
        mu.name AS municipio
    FROM persona p
    INNER JOIN registro_hecho rh
        ON p.id = rh.id_persona
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN manzana ma
        ON hh.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
    INNER JOIN municipio mu
        ON di.id_municipio = mu.id
    WHERE mu.name = 'Cartagena de Indias'
)
SELECT full_name, height, municipio
FROM personas_municipio
ORDER BY height DESC
LIMIT 1;









-- #46
-- Count people between 25 and 35 years old who reside in a specific municipality.
WITH personas_municipio AS (
    SELECT
        p.id,
        get_age(p.date_of_birth) AS age
    FROM persona p
    INNER JOIN registro_hecho rh
        ON p.id = rh.id_persona
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN manzana ma
        ON hh.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
    INNER JOIN municipio mu
        ON di.id_municipio = mu.id
    WHERE mu.name ILIKE 'Cartagena%'
)
SELECT COUNT(DISTINCT id) AS person_count
FROM personas_municipio
WHERE age BETWEEN 25 AND 35;




SELECT name FROM municipio ORDER BY name;

SELECT MIN(start_date) AS primera, MAX(start_date) AS ultima FROM registro_hecho;


SELECT COUNT(*) AS hogares_extranjero FROM hogar_hecho WHERE es_en_colombia = FALSE;
SELECT COUNT(*) AS militares_activos FROM persona WHERE military_situation = 'activa';