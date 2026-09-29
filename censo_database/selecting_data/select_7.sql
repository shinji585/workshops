CREATE 
OR REPLACE FUNCTION get_person_info(p persona)
RETURNS TABLE (
    full_name VARCHAR,
    age INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2)::VARCHAR,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.date_of_birth))::INTEGER;
END;
$$ LANGUAGE plpgsql STABLE;



WITH personas_calculadas AS (
    SELECT
        p.id,
        (get_person_info(p)).*
    FROM persona p
)
SELECT full_name, age
FROM personas_calculadas
WHERE age > 10;

WITH personas_calculadas AS (
    SELECT
        p.id,
        (get_person_info(p)).*
    FROM persona p
)
SELECT full_name, age
FROM personas_calculadas
WHERE age > 60;


WITH personas_calculadas AS (
    SELECT
        p.id,
        (get_person_info(p)).*
    FROM persona p
)
SELECT full_name, age
FROM personas_calculadas
WHERE age > 60;