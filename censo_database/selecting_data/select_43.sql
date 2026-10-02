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