ALTER TABLE "historial_estado_civil" ADD FOREIGN KEY ("id_persona") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;
