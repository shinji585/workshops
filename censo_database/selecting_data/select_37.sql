SELECT COUNT(*) AS person_count
FROM persona
WHERE education_level IN (
    'tecnico',
    'tecnologo',
    'universitario',
    'especializacion',
    'maestria',
    'doctorado'
);