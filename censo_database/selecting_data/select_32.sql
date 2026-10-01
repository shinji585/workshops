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
WHERE get_age(p.date_of_birth) < 18
  AND mu.name = 'Cartagena';