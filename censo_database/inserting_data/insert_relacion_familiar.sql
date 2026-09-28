INSERT INTO relacion_familiar (
    id,
    id_persona_a,
    id_persona_b,
    relationship_type
)
SELECT
    id,
    id_persona_a,
    id_persona_b,
    relationship_type
FROM jsonb_to_recordset(
    (:your_json_data)::jsonb -> 'relacion_familiar'
) AS x(
    id UUID,
    id_persona_a UUID,
    id_persona_b UUID,
    relationship_type relationship_type_enum
);