ALTER TABLE "hogar_hecho" ADD FOREIGN KEY ("id_manzana") REFERENCES "manzana" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "hogar_hecho" ADD FOREIGN KEY ("id_ciudad_extranjera") REFERENCES "ciudad_extranjera" ("id") DEFERRABLE INITIALLY IMMEDIATE;