INSERT INTO historial_estado_civil (
    id,
    id_persona,
    previous_status,
    new_status,
    change_date
)
SELECT
    id,
    id_persona,
    previous_status,
    new_status,
    change_date
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'historial_estado_civil'
) AS x(
    id UUID,
    id_persona UUID,
    previous_status marital_status_enum,
    new_status marital_status_enum,
    change_date DATE
);