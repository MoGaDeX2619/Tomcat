-- Base de datos para el módulo web CRUD - EA04
-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS ea4_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE ea4_db;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices para mejor rendimiento
    INDEX idx_nombre (nombre),
    INDEX idx_apellido (apellido),
    INDEX idx_email (email),
    INDEX idx_fecha_creacion (fecha_creacion)
);

-- Insertar datos de ejemplo para testing
INSERT INTO usuarios (nombre, apellido, email, telefono, direccion) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '12345678', 'Calle Principal #123, Ciudad'),
('María', 'González', 'maria.gonzalez@email.com', '87654321', 'Avenida Secundaria #456, Pueblo'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@email.com', '55555555', 'Boulevard Central #789, Villa'),
('Ana', 'Martínez', 'ana.martinez@email.com', '99999999', 'Plaza Mayor #101, Sector'),
('Luis', 'Sánchez', 'luis.sanchez@email.com', '11111111', 'Callejón del Sol #202, Barrio');

-- Mostrar los usuarios insertados
SELECT * FROM usuarios ORDER BY fecha_creacion DESC;
