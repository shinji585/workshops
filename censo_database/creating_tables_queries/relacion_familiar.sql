CREATE TABLE "relacion_familiar" (
  "id" uuid PRIMARY KEY,
  "id_persona_a" uuid NOT NULL,
  "id_persona_b" uuid NOT NULL,
  "relationship_type" relationship_type_enum NOT NULL,
  CONSTRAINT "chk_persona_relacion_diferente" CHECK ((id_persona_a <> id_persona_b))
);