-- #39
WITH personas_edad AS (
    SELECT 
        p.id,
        CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
        p.date_of_birth,
        get_age(p.date_of_birth) AS age
    FROM persona p
)
SELECT *
FROM personas_edad
WHERE age > 60
ORDER BY date_of_birth DESC
LIMIT 1;