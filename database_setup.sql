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

-- Crear tabla de usuarios con AUTO_INCREMENT correcto
CREATE TABLE usuarios (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'USER',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Verificar la estructura de la tabla
DESCRIBE usuarios;
