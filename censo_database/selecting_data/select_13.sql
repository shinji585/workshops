CREATE OR REPLACE FUNCTION get_age(date_of_birth DATE) 
RETURNS INTEGER
AS $$
BEGIN
    RETURN  EXTRACT(
        YEAR
        FROM AGE(date_of_birth)
    )::INTEGER;
END;
$$ LANGUAGE plpgsql;


SELECT COUNT(*)
FROM persona
WHERE get_age(date_of_birth) > 30;