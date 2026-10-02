SELECT COALESCE(SUM(total_personas)) AS person_count
FROM v_personas_por_nivel_educativo
WHERE education_level  < 'basica_secundaria';