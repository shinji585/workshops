CREATE TABLE "distrito" (
  "id" uuid PRIMARY KEY,
  "name" varchar(150) NOT NULL,
  "code" varchar NOT NULL,
  "id_municipio" uuid NOT NULL,
  CONSTRAINT "chk_distrito_nombre_no_vacio" CHECK (trim(name) <> '')
);