SELECT CONCAT_WS(' ', first_name, second_name, last_name1, last_name2) AS full_name,  get_age(date_of_birth)  AS age FROM persona
WHERE get_age(date_of_birth) BETWEEN 18  AND 25;