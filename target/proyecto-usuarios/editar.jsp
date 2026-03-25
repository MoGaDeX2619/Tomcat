<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus, select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        input[type="text"]:disabled, input[type="email"]:disabled, select:disabled {
            background-color: #f8f9fa;
            cursor: not-allowed;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-cancel {
            background-color: #6c757d;
        }
        .btn-cancel:hover {
            background-color: #545b62;
        }
        .buttons {
            text-align: center;
            margin-top: 30px;
        }
        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .error-list {
            margin: 0;
            padding-left: 20px;
        }
        .error-list li {
            margin-bottom: 5px;
        }
        .user-info {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .user-info strong {
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✏️ Editar Usuario</h1>
        
        <% 
        Usuario usuario = (Usuario) request.getAttribute("usuario");
        if (usuario != null) { 
        %>
            <%-- Mostrar errores de validación --%>
            <% if (request.getAttribute("errores") != null) { %>
                <div class="error">
                    <strong>Por favor corrija los siguientes errores:</strong>
                    <ul class="error-list">
                        <% 
                        java.util.List<String> errores = (java.util.List<String>) request.getAttribute("errores");
                        for (String error : errores) { 
                        %>
                            <li><%= error %></li>
                        <% } %>
                    </ul>
                </div>
            <% } %>
            
            <div class="user-info">
                <strong>ID de Usuario:</strong> <%= usuario.getIdUsuario() %>
            </div>
            
            <form action="usuario" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>">
                
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required
                           value="<%= usuario.getNombre() %>">
                </div>
                
                <div class="form-group">
                    <label for="correo">Correo electrónico:</label>
                    <input type="email" id="correo" name="correo" required
                           value="<%= usuario.getCorreo() %>">
                </div>
                
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required
                           value="<%= usuario.getContrasena() %>">
                    <small style="color: #666; font-size: 12px;">
                        Debe tener al menos 4 caracteres
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="rol">Rol:</label>
                    <select id="rol" name="rol" required>
                        <option value="">Seleccione un rol...</option>
                        <option value="ADMIN" 
                                <%= "ADMIN".equals(usuario.getRol()) ? "selected" : "" %>>Administrador</option>
                        <option value="USER" 
                                <%= "USER".equals(usuario.getRol()) ? "selected" : "" %>>Usuario</option>
                        <option value="MODERATOR" 
                                <%= "MODERATOR".equals(usuario.getRol()) ? "selected" : "" %>>Moderador</option>
                    </select>
                </div>
                
                <div class="buttons">
                    <button type="submit" class="btn">💾 Actualizar Usuario</button>
                    <a href="usuario?accion=listar" class="btn btn-cancel">🔙 Cancelar</a>
                </div>
            </form>
        <% } else { %>
            <div class="error">
                <strong>Error:</strong> Usuario no encontrado.
            </div>
            <div class="buttons">
                <a href="usuario?accion=listar" class="btn">📋 Ver Lista de Usuarios</a>
            </div>
        <% } %>
    </div>
</body>
</html>
