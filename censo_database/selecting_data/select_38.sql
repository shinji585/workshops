-- #20
-- Select all people who changed their address during the last year.
SELECT p.*
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
WHERE rh.start_date >= CURRENT_DATE - INTERVAL '1 year';


-- #21
-- Find the tallest person in a specific municipality.
SELECT p.*
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
WHERE mu.name = 'Cartagena'
ORDER BY p.height DESC
LIMIT 1;


-- #26
-- Select all people who reside in the same municipality where they are registered.
SELECT p.*
FROM persona p
INNER JOIN registro_derecho rd
    ON p.id = rd.id_persona
INNER JOIN hogar_derecho hd
    ON rd.id_hogar_derecho = hd.id
INNER JOIN manzana md
    ON hd.id_manzana = md.id
INNER JOIN distrito dd
    ON md.id_distrito = dd.id
INNER JOIN municipio mdm
    ON dd.id_municipio = mdm.id
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
INNER JOIN hogar_hecho hh
    ON rh.id_hogar_hecho = hh.id
INNER JOIN manzana mh
    ON hh.id_manzana = mh.id
INNER JOIN distrito dh
    ON mh.id_distrito = dh.id
INNER JOIN municipio mhm
    ON dh.id_municipio = mhm.id
WHERE mdm.id = mhm.id;


-- #29
-- Select people who moved to a foreign country from a specific municipality during the last five years.
SELECT p.*
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
INNER JOIN hogar_hecho hh
    ON rh.id_hogar_hecho = hh.id
INNER JOIN ciudad_extranjera ce
    ON hh.id_ciudad_extranjera = ce.id
INNER JOIN registro_derecho rd
    ON p.id = rd.id_persona
INNER JOIN hogar_derecho hd
    ON rd.id_hogar_derecho = hd.id
INNER JOIN manzana ma
    ON hd.id_manzana = ma.id
INNER JOIN distrito di
    ON ma.id_distrito = di.id
INNER JOIN municipio mu
    ON di.id_municipio = mu.id
WHERE hh.es_en_colombia = FALSE
  AND rh.start_date >= CURRENT_DATE - INTERVAL '5 years'
  AND mu.name = 'Cartagena';


-- #32
-- Select all people who changed municipality during the last year.
SELECT p.*
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
WHERE rh.start_date >= CURRENT_DATE - INTERVAL '1 year';


-- #35
-- Select people with active military status who are between 18 and 30 years old.
SELECT *
FROM persona
WHERE military_situation = 'activa'
  AND get_age(date_of_birth) BETWEEN 18 AND 30;


-- #40
-- Select all people who have been residing in a foreign country for more than 10 years.
SELECT p.*
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
INNER JOIN hogar_hecho hh
    ON rh.id_hogar_hecho = hh.id
INNER JOIN ciudad_extranjera ce
    ON hh.id_ciudad_extranjera = ce.id
WHERE hh.es_en_colombia = FALSE
  AND rh.start_date < CURRENT_DATE - INTERVAL '10 years'
  AND rh.end_date IS NULL;


-- #41
-- Find the tallest person over 50 years old in a specific municipality.
SELECT p.*
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
WHERE get_age(p.date_of_birth) > 50
  AND mu.name = 'Cartagena'
ORDER BY p.height DESC
LIMIT 1;


-- #45
-- Select all people who changed their address during the last six months.
SELECT p.*
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
WHERE rh.start_date >= CURRENT_DATE - INTERVAL '6 months';


-- #46
-- Count people between 25 and 35 years old who reside in a specific municipality.
SELECT COUNT(*) AS person_count
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
WHERE get_age(p.date_of_birth) BETWEEN 25 AND 35
  AND mu.name = 'Cartagena';


-- #49
-- Select all people who have a doctoral education level.
SELECT *
FROM persona
WHERE education_level = 'doctorado';