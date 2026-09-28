CREATE TABLE "lugar_universal" (
  "id" uuid PRIMARY KEY,
  "name" varchar(150) NOT NULL,
  "es_extranjero" bool NOT NULL DEFAULT false,
  "id_municipio_colombia" uuid,
  "id_ciudad_extranjera" uuid,
  CONSTRAINT "chk_lugar_consistencia" CHECK ((es_extranjero = false AND id_municipio_colombia IS NOT NULL AND id_ciudad_extranjera IS NULL) OR (es_extranjero = true AND id_municipio_colombia IS NULL AND id_ciudad_extranjera IS NOT NULL)),
  CONSTRAINT "chk_lugar_nombre_no_vacio" CHECK (trim(name) <> '')
);