ALTER TABLE "verificacion_identidad" ADD FOREIGN KEY ("id_persona") REFERENCES "persona" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "verificacion_identidad" ADD FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;