-- #19
WITH personas_municipio AS (
    SELECT DISTINCT
        p.id,
        get_age(p.date_of_birth) AS age,
        mu.name AS municipio
    FROM persona p
        INNER JOIN registro_hecho rh ON p.id = rh.id_persona
        INNER JOIN hogar_hecho hh ON rh.id_hogar_hecho = hh.id
        INNER JOIN manzana ma ON hh.id_manzana = ma.id
        INNER JOIN distrito di ON ma.id_distrito = di.id
        INNER JOIN municipio mu ON di.id_municipio = mu.id
    WHERE mu.name ILIKE 'Cartagena de Indias'
)
SELECT 
    municipio,
    COUNT(id) AS total_mayores_50
FROM personas_municipio
WHERE age >= 50
GROUP BY municipio;
