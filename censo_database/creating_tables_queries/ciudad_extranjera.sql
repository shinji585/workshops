CREATE TABLE "ciudad_extranjera" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "state_province" varchar,
  "id_pais" uuid NOT NULL,
  CONSTRAINT "chk_ciudad_extranjera_nombre_no_vacio" CHECK (trim(name) <> '')
);