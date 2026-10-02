-- #45
SELECT 
    p.id,
    CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2) AS full_name,
    p.height,
    p.sex,
    get_age(p.date_of_birth) AS age
FROM persona p
WHERE p.sex = 'M'
ORDER BY p.height ASC
LIMIT 1;