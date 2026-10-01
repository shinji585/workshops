WITH get_universal_place AS (
    SELECT p.*
    FROM persona p
        INNER JOIN lugar_universal lu ON p.id_lugar_nacimiento = lu.id
    WHERE es_extranjero = FALSE
)
SELECT *
FROM get_universal_place
WHERE get_age(date_of_birth) = (
    SELECT MIN(get_age(date_of_birth))
    FROM get_universal_place
);