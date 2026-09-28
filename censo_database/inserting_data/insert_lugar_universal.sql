INSERT INTO lugar_universal (
    id,
    name,
    es_extranjero,
    id_municipio_colombia,
    id_ciudad_extranjera
)
SELECT
    id,
    name,
    es_extranjero,
    id_municipio_colombia,
    id_ciudad_extranjera
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'lugar_universal'
) AS x(
    id UUID,
    name VARCHAR(150),
    es_extranjero BOOLEAN,
    id_municipio_colombia UUID,
    id_ciudad_extranjera UUID
);