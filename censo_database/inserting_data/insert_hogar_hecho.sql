INSERT INTO hogar_hecho (
    id,
    street,
    number,
    es_en_colombia,
    id_manzana,
    id_ciudad_extranjera,
    latitude,
    longitude
)
SELECT
    id,
    street,
    number,
    es_en_colombia,
    id_manzana,
    id_ciudad_extranjera,
    latitude,
    longitude
FROM jsonb_to_recordset(
    :'json_data'::jsonb -> 'hogar_hecho'
) AS x(
    id UUID,
    street VARCHAR,
    number VARCHAR,
    es_en_colombia BOOLEAN,
    id_manzana UUID,
    id_ciudad_extranjera UUID,
    latitude NUMERIC,
    longitude NUMERIC
);