CREATE TABLE "hogar_derecho" (
  "id" uuid PRIMARY KEY,
  "street" varchar NOT NULL,
  "number" varchar NOT NULL,
  "id_manzana" uuid NOT NULL,
  "latitude" numeric,
  "longitude" numeric,
  CHECK ((latitude BETWEEN -90 AND 90)),
  CHECK ((longitude BETWEEN -180 AND 180)),
  CONSTRAINT "chk_hogar_derecho_street_no_vacio" CHECK (trim(street) <> '')
);