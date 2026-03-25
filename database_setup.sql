-- Script SQL para crear la base de datos y tabla de usuarios
-- Base de datos: nelson_prueba

-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS nelson_prueba 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE nelson_prueba;

-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'USER',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar datos de ejemplo con contraseñas hasheadas en MD5
-- admin123 -> 0192023a7bbd73250516f069df18b500
-- user123 -> 482c811da5d5b4bc6d497ffa98491e38
-- mod123 -> 5d9c68c6c50ed3d02a2fcf54f1e80dbd
INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES
('Administrador', 'admin@ejemplo.com', '0192023a7bbd73250516f069df18b500', 'ADMIN'),
('Usuario Ejemplo', 'usuario@ejemplo.com', '482c811da5d5b4bc6d497ffa98491e38', 'USER'),
('Moderador Sistema', 'moderador@ejemplo.com', '5d9c68c6c50ed3d02a2fcf54f1e80dbd', 'MODERATOR')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Mostrar los usuarios insertados
SELECT * FROM usuarios;
