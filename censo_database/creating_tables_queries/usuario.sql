CREATE TABLE "usuario" (
  "id" uuid PRIMARY KEY,
  "username" varchar(50) UNIQUE NOT NULL,
  "password_hash" text NOT NULL,
  "id_rol" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT false,
  CONSTRAINT "chk_usuario_username_no_vacio" CHECK (trim(username) <> '')
);