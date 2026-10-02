-- #32
-- Select all people who changed municipality during the last year.
WITH residencias AS (
    SELECT
        rh.id_persona,
        rh.start_date,
        COALESCE(mu.name, ce.name) AS lugar,
        COALESCE(mu.id, ce.id)     AS id_lugar
    FROM registro_hecho rh
    INNER JOIN hogar_hecho hh
        ON rh.id_hogar_hecho = hh.id
    LEFT JOIN manzana ma
        ON hh.id_manzana = ma.id
    LEFT JOIN distrito di
        ON ma.id_distrito = di.id
    LEFT JOIN municipio mu
        ON di.id_municipio = mu.id
    LEFT JOIN ciudad_extranjera ce
        ON hh.id_ciudad_extranjera = ce.id
),
cambios AS (
    SELECT
        id_persona,
        start_date,
        lugar    AS lugar_nuevo,
        id_lugar,
        LAG(lugar)    OVER (PARTITION BY id_persona ORDER BY start_date) AS lugar_anterior,
        LAG(id_lugar) OVER (PARTITION BY id_persona ORDER BY start_date) AS id_lugar_anterior
    FROM residencias
)
SELECT
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    c.lugar_anterior,
    c.lugar_nuevo,
    c.start_date
FROM cambios c
INNER JOIN persona p
    ON p.id = c.id_persona
WHERE c.id_lugar_anterior IS NOT NULL
  AND c.id_lugar <> c.id_lugar_anterior
  -- para la demo con los datos actuales cambia '1 year' por '5 years'
  AND c.start_date >= CURRENT_DATE - INTERVAL '5 year';