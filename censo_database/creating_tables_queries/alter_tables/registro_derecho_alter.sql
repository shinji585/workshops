ALTER TABLE "registro_derecho" ADD FOREIGN KEY ("id_persona") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "registro_derecho" ADD FOREIGN KEY ("id_hogar_derecho") REFERENCES "hogar_derecho" ("id") DEFERRABLE INITIALLY IMMEDIATE;