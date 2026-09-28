CREATE TABLE "departamento" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) UNIQUE NOT NULL,
  "code" varchar UNIQUE NOT NULL,
  CONSTRAINT "chk_departamento_code" CHECK (code ~ '^[0-9]{2}$'),
  CONSTRAINT "chk_departamento_nombre_no_vacio" CHECK (trim(name) <> '')
);