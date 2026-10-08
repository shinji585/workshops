CREATE TYPE rol_empleado AS ENUM (
    'Administrador',
    'Cajero',
    'Reponedor',
    'Encargado_Almacen',
    'Personal_Limpieza',
    'Seguridad',
    'Atencion_Cliente'
);

CREATE TYPE estado_empleado AS ENUM (
    'Activo',
    'Inactivo',
    'De_Vacaciones',
    'Baja_Medica'
);


CREATE TABLE IF NOT EXISTS persona_data (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cedula VARCHAR(11) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS cliente (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_personal_data BIGINT UNIQUE NOT NULL,
    ciudad_residencia VARCHAR(75),
    email VARCHAR(255) UNIQUE,

    CONSTRAINT client_persona_data_fk 
    FOREIGN KEY (id_personal_data)
    REFERENCES persona_data(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS empleado (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_personal_data BIGINT UNIQUE NOT NULL,
    cargo rol_empleado NOT NULL,
    estado estado_empleado NOT NULL DEFAULT 'Activo',

    CONSTRAINT empleado_persona_data_fk 
    FOREIGN KEY (id_personal_data)
    REFERENCES persona_data(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS categoria (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS producto (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria BIGINT NOT NULL, -- Sin UNIQUE para permitir varios productos por categoría
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),

    CONSTRAINT producto_categoria_fk
    FOREIGN KEY (id_categoria)
    REFERENCES categoria(id)
);


CREATE TABLE IF NOT EXISTS venta (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente BIGINT NOT NULL,
    id_empleado BIGINT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT venta_cliente_fk
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id),

    CONSTRAINT venta_empleado_fk 
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id)
);


CREATE TABLE IF NOT EXISTS detalle_venta (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_venta BIGINT NOT NULL,
    id_producto BIGINT NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),

    CONSTRAINT detalle_venta_venta_fk
    FOREIGN KEY (id_venta)
    REFERENCES venta(id) ON DELETE CASCADE,

    CONSTRAINT detalle_venta_producto_fk
    FOREIGN KEY (id_producto)
    REFERENCES producto(id)
);