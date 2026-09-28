ALTER TABLE "registro_hecho" ADD FOREIGN KEY ("id_persona") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "registro_hecho" ADD FOREIGN KEY ("id_hogar_hecho") REFERENCES "hogar_hecho" ("id") DEFERRABLE INITIALLY IMMEDIATE;