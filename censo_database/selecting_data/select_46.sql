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
      AND rh.start_date < CURRENT_DATE - INTERVAL '1 years'
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