SELECT CONCAT_WS(
        ' ',
        first_name,
        second_name,
        last_name1,
        last_name2
    ),
    get_age(date_of_birth),
    education_level
FROM persona
WHERE  get_age(date_of_birth) > 30
ORDER BY get_age(date_of_birth) ASC
LIMIT 1;
