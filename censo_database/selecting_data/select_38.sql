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

-- #26
-- Select all people who reside in the same municipality where they are registered.
WITH municipio_censo AS (
    SELECT rd.id_persona, di.id_municipio
    FROM registro_derecho rd
    INNER JOIN hogar_derecho hd
        ON rd.id_hogar_derecho = hd.id
    INNER JOIN manzana ma
        ON hd.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
),
municipio_residencia AS (
    SELECT rh.id_persona, di.id_municipio
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN manzana ma
        ON hh.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
)
SELECT DISTINCT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    mu.name AS municipio
FROM persona p
INNER JOIN municipio_censo mc
    ON mc.id_persona = p.id
INNER JOIN municipio_residencia mr
    ON mr.id_persona = p.id
   AND mr.id_municipio = mc.id_municipio
INNER JOIN municipio mu
    ON mu.id = mc.id_municipio;


-- #29
-- Select people who moved to a foreign country from a specific municipality during the last five years.
WITH mudanzas_extranjero AS (
    SELECT
        rh.id_persona,
        rh.start_date,
        ce.name AS ciudad_destino,
        ps.name AS pais_destino
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN ciudad_extranjera ce
        ON hh.id_ciudad_extranjera = ce.id
    INNER JOIN pais ps
        ON ce.id_pais = ps.id
    WHERE hh.es_en_colombia = FALSE
      AND rh.start_date >= CURRENT_DATE - INTERVAL '5 years'
),
municipio_origen AS (
    SELECT rd.id_persona, mu.name AS municipio_origen
    FROM registro_derecho rd
    INNER JOIN hogar_derecho hd
        ON rd.id_hogar_derecho = hd.id
    INNER JOIN manzana ma
        ON hd.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
    INNER JOIN municipio mu
        ON di.id_municipio = mu.id
    WHERE mu.name ILIKE 'Cartagena%'
)
SELECT DISTINCT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    mo.municipio_origen,
    me.ciudad_destino,
    me.pais_destino,
    me.start_date
FROM persona p
INNER JOIN mudanzas_extranjero me
    ON me.id_persona = p.id
INNER JOIN municipio_origen mo
    ON mo.id_persona = p.id;


-- #32
-- Select all people who changed municipality during the last year.
WITH residencias_recientes AS (
    SELECT
        rh.id_persona,
        rh.start_date,
        mu.name AS municipio
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN manzana ma
        ON hh.id_manzana = ma.id
    INNER JOIN distrito di
        ON ma.id_distrito = di.id
    INNER JOIN municipio mu
        ON di.id_municipio = mu.id
    WHERE rh.start_date >= CURRENT_DATE - INTERVAL '1 year'
)
SELECT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    rr.municipio,
    rr.start_date
FROM persona p
INNER JOIN residencias_recientes rr
    ON rr.id_persona = p.id;


-- #35
-- Select people with active military status who are between 18 and 30 years old.
WITH personas_militares AS (
    SELECT
        CONCAT_WS(' ', first_name, second_name, last_name1, last_name2) AS full_name,
        get_age(date_of_birth) AS age,
        military_situation
    FROM persona
    WHERE military_situation = 'activa'
)
SELECT full_name, age, military_situation
FROM personas_militares
WHERE age BETWEEN 18 AND 30;


-- #40
-- Select all people who have been residing in a foreign country for more than 10 years.
WITH residentes_extranjero AS (
    SELECT
        rh.id_persona,
        rh.start_date,
        ce.name AS ciudad,
        ps.name AS pais
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    INNER JOIN ciudad_extranjera ce
        ON hh.id_ciudad_extranjera = ce.id
    INNER JOIN pais ps
        ON ce.id_pais = ps.id
    WHERE hh.es_en_colombia = FALSE
      AND rh.start_date < CURRENT_DATE - INTERVAL '10 years'
      AND rh.end_date IS NULL
)
SELECT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    re.ciudad,
    re.pais,
    re.start_date
FROM persona p
INNER JOIN residentes_extranjero re
    ON re.id_persona = p.id;


-- #41
-- Find the tallest person over 50 years old in a specific municipality.
WITH personas_municipio AS (
    SELECT
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
        p.height,
        get_age(p.date_of_birth) AS age,
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
    WHERE mu.name ILIKE 'Cartagena%'
)
SELECT full_name, height, age, municipio
FROM personas_municipio
WHERE age > 50
ORDER BY height DESC
LIMIT 1;


-- #45
-- Select all people who changed their address during the last six months.
WITH cambios_recientes AS (
    SELECT
        rh.id_persona,
        rh.start_date,
        hh.street,
        hh.number
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    WHERE rh.start_date >= CURRENT_DATE - INTERVAL '6 months'
)
SELECT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    cr.street,
    cr.number,
    cr.start_date
FROM persona p
INNER JOIN cambios_recientes cr
    ON cr.id_persona = p.id;


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