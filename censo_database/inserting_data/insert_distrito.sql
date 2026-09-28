INSERT INTO distrito (
    id,
    name,
    code,
    id_municipio
)
SELECT
    id,
    name,
    code,
    id_municipio
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'distrito'
) AS x(
    id UUID,
    name VARCHAR(150),
    code VARCHAR,
    id_municipio UUID
);