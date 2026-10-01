SELECT COUNT(*) AS person_count
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
INNER JOIN hogar_hecho hh
    ON rh.id_hogar_hecho = hh.id
INNER JOIN ciudad_extranjera ce
    ON hh.id_ciudad_extranjera = ce.id
WHERE hh.es_en_colombia = FALSE;