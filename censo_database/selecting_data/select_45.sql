-- #35
-- Select people with active military status who are between 18 and 30 years old.
WITH personas_militares AS (
    SELECT
        CONCAT_WS(' ', first_name, second_name, last_name1, last_name2) AS full_name,
        get_age(date_of_birth) AS age,
        military_situation
    FROM persona
    WHERE military_situation = 'activa'
)
SELECT full_name, age, military_situation
FROM personas_militares
WHERE age BETWEEN 18 AND 30;