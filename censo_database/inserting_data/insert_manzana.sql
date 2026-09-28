INSERT INTO manzana (
    id,
    code,
    id_distrito
)
SELECT
    id,
    code,
    id_distrito
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'manzana'
) AS x(
    id UUID,
    code VARCHAR(4),
    id_distrito UUID
);