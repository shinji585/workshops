SELECT COUNT(*) AS person_count
FROM persona
WHERE education_level IN (
    'basica_secundaria',
    'media'
);