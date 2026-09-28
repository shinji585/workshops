INSERT INTO registro_derecho (
    id,
    id_persona,
    id_hogar_derecho,
    registration_date,
    is_active
)
SELECT
    id,
    id_persona,
    id_hogar_derecho,
    registration_date,
    is_active
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'registro_derecho'
) AS x(
    id UUID,
    id_persona UUID,
    id_hogar_derecho UUID,
    registration_date DATE,
    is_active BOOLEAN
);