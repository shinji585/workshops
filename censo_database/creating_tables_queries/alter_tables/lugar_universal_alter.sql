ALTER TABLE "lugar_universal" ADD FOREIGN KEY ("id_municipio_colombia") REFERENCES "municipio" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "lugar_universal" ADD FOREIGN KEY ("id_ciudad_extranjera") REFERENCES "ciudad_extranjera" ("id") DEFERRABLE INITIALLY IMMEDIATE;