ALTER TABLE "relacion_familiar" ADD FOREIGN KEY ("id_persona_a") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "relacion_familiar" ADD FOREIGN KEY ("id_persona_b") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;