INSERT INTO municipio (
    id,
    name,
    code,
    id_departamento
)
SELECT
    id,
    name,
    code,
    id_departamento
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'municipio'
) AS x(
    id UUID,
    name VARCHAR(100),
    code VARCHAR(5),
    id_departamento UUID
);