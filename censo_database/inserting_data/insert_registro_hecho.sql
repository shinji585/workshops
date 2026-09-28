INSERT INTO registro_hecho (
    id,
    id_persona,
    id_hogar_hecho,
    start_date,
    end_date
)
SELECT
    id,
    id_persona,
    id_hogar_hecho,
    start_date,
    end_date
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'registro_hecho'
) AS x(
    id UUID,
    id_persona UUID,
    id_hogar_hecho UUID,
    start_date DATE,
    end_date DATE
);