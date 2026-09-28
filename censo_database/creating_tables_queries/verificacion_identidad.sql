CREATE TABLE "verificacion_identidad" (
  "id" uuid PRIMARY KEY,
  "id_persona" uuid NOT NULL,
  "method" identity_verification_method_enum NOT NULL,
  "verified_at" timestamp NOT NULL,
  "id_usuario" uuid NOT NULL,
  "status" identity_verification_status_enum NOT NULL
);