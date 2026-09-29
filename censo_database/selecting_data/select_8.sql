CREATE 
OR REPLACE FUNCTION get_person_info_education(p persona)
RETURNS TABLE (
    full_name VARCHAR,
    education_level VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2)::VARCHAR,
        p.education_level::VARCHAR;
END;
$$ LANGUAGE plpgsql STABLE;



WITH personas_calculadas AS (
    SELECT
        p.id,
        (get_person_info_education(p)).*
    FROM persona p
)
SELECT full_name, education_level
FROM personas_calculadas
WHERE education_level IN ('basica_primaria', 'universitario', 'doctorado')
ORDER BY education_level;


-- el sistema leé los 3 tipos de queries requeridas sin tener que realizarlo individualmente y solo muestra el nivel de eduacion de las personas registrados en el sistema que esta en el where
