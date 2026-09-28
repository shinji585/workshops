ALTER TABLE "municipio" ADD FOREIGN KEY ("id_departamento") REFERENCES "departamento" ("id") DEFERRABLE INITIALLY IMMEDIATE;
