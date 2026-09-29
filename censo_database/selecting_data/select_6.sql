SELECT CONCAT_WS(' ', p.first_name, p.second_name, p.last_name1, p.last_name2), military_situation
FROM persona p
WHERE military_situation = 'activa';