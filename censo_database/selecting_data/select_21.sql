WITH get_universal_place AS (
    SELECT p.*,
           lu.id_municipio_colombia
    FROM persona p
        INNER JOIN lugar_universal lu ON p.id_lugar_nacimiento = lu.id
)
SELECT de.name, COUNT(*)
FROM get_universal_place ord
    INNER JOIN municipio mu ON ord.id_municipio_colombia = mu.id
    INNER JOIN departamento de ON mu.id_departamento = de.id
WHERE get_age(date_of_birth) > 40
GROUP BY de.name;


SELECT first_name, get_age(date_of_birth) FROM persona;