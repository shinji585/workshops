ALTER TABLE "persona" ADD FOREIGN KEY ("id_lugar_nacimiento") REFERENCES "lugar_universal" ("id") DEFERRABLE INITIALLY IMMEDIATE;
