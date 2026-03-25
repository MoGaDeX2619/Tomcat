<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Usuarios</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .menu {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .menu-item {
            display: block;
            padding: 15px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .menu-item:hover {
            background-color: #0056b3;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .description {
            color: #666;
            text-align: center;
            margin-bottom: 30px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>👥 Sistema de Gestión de Usuarios</h1>
        </div>
        
        <div class="description">
            <p>Aplicación web para gestionar usuarios del sistema.</p>
            <p>Permite crear, listar, editar y eliminar usuarios de forma sencilla.</p>
        </div>
        
        <div class="menu">
            <a href="usuario?accion=listar" class="menu-item">
                📋 Listar Usuarios
            </a>
            <a href="crear.jsp" class="menu-item">
                ➕ Crear Nuevo Usuario
            </a>
        </div>
        
        <div style="margin-top: 30px; text-align: center; color: #666; font-size: 14px;">
            <p>Desarrollado con Java Servlets, JSP y MySQL</p>
            <p>Compatible con Apache Tomcat 10</p>
        </div>
    </div>
</body>
</html>
