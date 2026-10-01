SELECT CONCAT_WS(
        ' ',
        first_name,
        second_name,
        last_name1,
        last_name2
    ),
    height
FROM persona
WHERE sex = 'F' AND get_age(date_of_birth) > 40
ORDER BY height DESC;