INSERT INTO rol (
    id,
    name,
    description
)
SELECT
    id,
    name,
    description
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'rol'
) AS x(
    id UUID,
    name rol_enum,
    description TEXT
);