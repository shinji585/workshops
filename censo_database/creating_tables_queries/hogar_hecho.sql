CREATE TABLE "hogar_hecho" (
  "id" uuid PRIMARY KEY,
  "street" varchar NOT NULL,
  "number" varchar NOT NULL,
  "es_en_colombia" bool NOT NULL DEFAULT true,
  "id_manzana" uuid,
  "id_ciudad_extranjera" uuid,
  "latitude" numeric,
  "longitude" numeric,
  CONSTRAINT "chk_hogar_hecho_ubicacion" CHECK ((es_en_colombia = true AND id_manzana IS NOT NULL AND id_ciudad_extranjera IS NULL) OR (es_en_colombia = false AND id_manzana IS NULL AND id_ciudad_extranjera IS NOT NULL)),
  CHECK ((latitude BETWEEN -90 AND 90)),
  CHECK ((longitude BETWEEN -180 AND 180)),
  CONSTRAINT "chk_hogar_hecho_street_no_vacio" CHECK (trim(street) <> '')
);