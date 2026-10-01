SELECT COUNT(*) AS person_count
FROM persona p
INNER JOIN registro_hecho rh
    ON p.id = rh.id_persona
INNER JOIN hogar_hecho hh
    ON rh.id_hogar_hecho = hh.id
WHERE hh.street = 'Carrera 10'
  AND hh.number = '25-15';