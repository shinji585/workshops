SELECT COUNT(*) AS person_count
FROM historial_estado_civil
WHERE change_date >= CURRENT_DATE - INTERVAL '1 year';