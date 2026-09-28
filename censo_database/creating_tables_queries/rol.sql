CREATE TABLE "rol" (
  "id" uuid PRIMARY KEY,
  "name" rol_enum UNIQUE NOT NULL,
  "description" text
);