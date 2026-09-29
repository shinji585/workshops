SELECT CONCAT(
        first_name,
        ' ',
        second_name,
        ' ',
        last_name1,
        ' ', last_name2
    ) AS full_name, date_of_birth FROM persona
WHERE date_of_birth > '1990-01-01';