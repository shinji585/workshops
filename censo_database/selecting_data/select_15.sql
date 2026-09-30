SELECT first_name, MAX(height) AS max_height FROM persona
WHERE sex = 'M'
GROUP BY first_name
ORDER BY max_height DESC
LIMIT 1;