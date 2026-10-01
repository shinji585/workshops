SELECT CONCAT_WS(
        ' ',
        first_name,
        second_name,
        last_name1,
        last_name2
    ),
    height
FROM persona
WHERE sex = 'F'
ORDER BY height DESC
LIMIT 1;