CREATE TABLE "municipio" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "code" varchar(5) UNIQUE NOT NULL,
  "id_departamento" uuid NOT NULL,
  CONSTRAINT "chk_municipio_nombre_no_vacio" CHECK (trim(name) <> '')
);