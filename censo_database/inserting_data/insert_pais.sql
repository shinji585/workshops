INSERT INTO pais (id, name, code_iso)
SELECT id, name, code_iso
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'pais'
) AS x(
    id UUID,
    name VARCHAR(100),
    code_iso VARCHAR(2)
);