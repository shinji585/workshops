CREATE TABLE "manzana" (
  "id" uuid PRIMARY KEY,
  "code" varchar(4) NOT NULL,
  "id_distrito" uuid NOT NULL,
  CONSTRAINT "chk_manzana_code" CHECK (code ~ '^[0-9]{4}$')
);