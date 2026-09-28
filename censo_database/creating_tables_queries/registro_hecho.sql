CREATE TABLE "registro_hecho" (
  "id" uuid PRIMARY KEY,
  "id_persona" uuid NOT NULL,
  "id_hogar_hecho" uuid NOT NULL,
  "start_date" date NOT NULL,
  "end_date" date,
  CHECK ((end_date IS NULL OR end_date >= start_date))
);