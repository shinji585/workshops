CREATE TABLE "registro_derecho" (
  "id" uuid PRIMARY KEY,
  "id_persona" uuid NOT NULL,
  "id_hogar_derecho" uuid NOT NULL,
  "registration_date" date NOT NULL,
  "is_active" bool NOT NULL DEFAULT true
);