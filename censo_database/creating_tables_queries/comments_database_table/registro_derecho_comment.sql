COMMENT ON TABLE "registro_derecho" IS 'Requires SQL after export: CREATE UNIQUE INDEX unique_active_registro_derecho ON registro_derecho (id_persona) WHERE is_active = true;';
