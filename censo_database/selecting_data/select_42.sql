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