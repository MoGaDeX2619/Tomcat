-- Script SQL para crear la base de datos y tabla de usuarios
-- Base de datos: nelson_prueba

-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS nelson_prueba 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE nelson_prueba;

-- Eliminar la tabla si existe para recrearla correctamente
DROP TABLE IF EXISTS usuarios;

-- Crear tabla de usuarios según estructura actual en HeidiSQL
CREATE TABLE usuarios (
    idUsuario INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    contrasena VARCHAR(255),
    cedula VARCHAR(100),
    fecha_nacimiento VARCHAR(50),
    rol VARCHAR(50)
);

-- Verificar la estructura de la tabla
DESCRIBE usuarios;

-- Insertar algunos datos de ejemplo para pruebas
INSERT INTO usuarios (idUsuario, nombre, correo, contrasena, cedula, fecha_nacimiento, rol) VALUES
(1, 'Administrador Sistema', 'admin@ejemplo.com', '202cb962ac59075b964b07152d234b70', '00123456789', '1990-01-15', 'ADMIN'),
(2, 'Juan Pérez', 'juan.perez@ejemplo.com', '202cb962ac59075b964b07152d234b70', '00234567890', '1985-05-20', 'USER'),
(3, 'María García', 'maria.garcia@ejemplo.com', '202cb962ac59075b964b07152d234b70', '00345678901', '1992-08-10', 'USER');

-- Mostrar los datos insertados
SELECT * FROM usuarios ORDER BY idUsuario;
