INSERT INTO departamento (id, name, code)
SELECT id, name, code
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'departamento'
) AS x(
    id UUID,
    name VARCHAR(100),
    code VARCHAR
);