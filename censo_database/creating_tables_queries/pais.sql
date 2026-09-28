CREATE TABLE "pais" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) UNIQUE NOT NULL,
  "code_iso" varchar(2) UNIQUE NOT NULL,
  CONSTRAINT "chk_pais_nombre_no_vacio" CHECK (trim(name) <> '')
);