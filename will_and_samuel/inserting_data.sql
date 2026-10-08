\copy persona_data(id, nombre, apellido, cedula) FROM '/home/toji/projects/workshops/will_and_samuel/01_persona_data.csv' DELIMITER ',' CSV HEADER;
\copy cliente(id, id_personal_data, ciudad_residencia, email) FROM '/home/toji/projects/workshops/will_and_samuel/02_cliente.csv' DELIMITER ',' CSV HEADER;
\copy empleado(id, id_personal_data, cargo, estado, salario) FROM '/home/toji/projects/workshops/will_and_samuel/03_empleado.csv' DELIMITER ',' CSV HEADER;
\copy categoria(id, nombre) FROM '/home/toji/projects/workshops/will_and_samuel/04_categoria.csv' DELIMITER ',' CSV HEADER;
\copy producto(id, nombre, id_categoria, precio_unitario, stock) FROM '/home/toji/projects/workshops/will_and_samuel/05_producto.csv' DELIMITER ',' CSV HEADER;
\copy venta(id, id_cliente, id_empleado, fecha) FROM '/home/toji/projects/workshops/will_and_samuel/06_venta.csv' DELIMITER ',' CSV HEADER;
\copy detalle_venta(id, id_venta, id_producto, cantidad, precio_unitario) FROM '/home/toji/projects/workshops/will_and_samuel/07_detalle_venta.csv' DELIMITER ',' CSV HEADER;

SELECT setval(pg_get_serial_sequence('persona_data', 'id'), COALESCE(MAX(id), 1)) FROM persona_data;
SELECT setval(pg_get_serial_sequence('cliente', 'id'), COALESCE(MAX(id), 1)) FROM cliente;
SELECT setval(pg_get_serial_sequence('empleado', 'id'), COALESCE(MAX(id), 1)) FROM empleado;
SELECT setval(pg_get_serial_sequence('categoria', 'id'), COALESCE(MAX(id), 1)) FROM categoria;
SELECT setval(pg_get_serial_sequence('producto', 'id'), COALESCE(MAX(id), 1)) FROM producto;
SELECT setval(pg_get_serial_sequence('venta', 'id'), COALESCE(MAX(id), 1)) FROM venta;
SELECT setval(pg_get_serial_sequence('detalle_venta', 'id'), COALESCE(MAX(id), 1)) FROM detalle_venta;