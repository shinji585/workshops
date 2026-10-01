SELECT COUNT(*) AS person_count
FROM persona
WHERE education_level IN (
    'especializacion',
    'maestria',
    'doctorado'
);