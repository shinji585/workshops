CREATE TABLE "historial_estado_civil" (
  "id" uuid PRIMARY KEY,
  "id_persona" uuid NOT NULL,
  "previous_status" marital_status_enum NOT NULL,
  "new_status" marital_status_enum NOT NULL,
  "change_date" date NOT NULL,
  CONSTRAINT "chk_estado_civil_diferente" CHECK ((previous_status <> new_status))
);