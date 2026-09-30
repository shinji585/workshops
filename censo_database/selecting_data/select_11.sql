SELECT EXTRACT(
        YEAR
        FROM AGE(date_of_birth)
    ) AS age
FROM persona
ORDER BY age ASC
LIMIT 1;