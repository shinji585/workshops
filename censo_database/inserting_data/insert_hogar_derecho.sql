INSERT INTO hogar_derecho (
    id,
    street,
    number,
    id_manzana,
    latitude,
    longitude
)
SELECT
    id,
    street,
    number,
    id_manzana,
    latitude,
    longitude
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'hogar_derecho'
) AS x(
    id UUID,
    street VARCHAR,
    number VARCHAR,
    id_manzana UUID,
    latitude NUMERIC,
    longitude NUMERIC
);