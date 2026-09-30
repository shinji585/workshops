SELECT first_name, MAX(height) AS max_height FROM persona
WHERE sex = 'F'
GROUP BY first_name
ORDER BY max_height ASC
LIMIT 1;