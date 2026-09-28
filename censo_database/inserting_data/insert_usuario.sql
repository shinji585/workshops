INSERT INTO usuario (
    id,
    username,
    password_hash,
    id_rol,
    active
)
SELECT
    id,
    username,
    password_hash,
    id_rol,
    active
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'usuario'
) AS x(
    id UUID,
    username VARCHAR(50),
    password_hash TEXT,
    id_rol UUID,
    active BOOLEAN
);