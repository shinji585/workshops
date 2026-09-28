INSERT INTO ciudad_extranjera (
    id,
    name,
    state_province,
    id_pais
)
SELECT
    id,
    name,
    state_province,
    id_pais
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'ciudad_extranjera'
) AS x(
    id UUID,
    name VARCHAR(100),
    state_province TEXT,
    id_pais UUID
);