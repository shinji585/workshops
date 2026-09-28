INSERT INTO verificacion_identidad (
    id,
    id_persona,
    method,
    verified_at,
    id_usuario,
    status
)
SELECT
    id,
    id_persona,
    method,
    verified_at,
    id_usuario,
    status
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'verificacion_identidad'
) AS x(
    id UUID,
    id_persona UUID,
    method identity_verification_method_enum,
    verified_at TIMESTAMP,
    id_usuario UUID,
    status identity_verification_status_enum
);