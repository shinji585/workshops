
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