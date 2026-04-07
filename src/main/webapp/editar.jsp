<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario | E-form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #f0f7ff 0%, #e6f2ff 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.15); /* Ultra transparente */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 102, 204, 0.1);
            backdrop-filter: blur(1px); /* Casi sin blur */
            z-index: 10;
            position: relative;
        }
        
        .background-logo {
            position: fixed;
            bottom: 200px; /* Más abajo para que sea visible */
            left: 50%;
            transform: translateX(-50%);
            z-index: 1;
            opacity: 0.4; /* Más opaco para que las letras se vean mejor */
            pointer-events: none;
        }
        
        .background-logo img {
            width: 300px;
            height: 300px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid rgba(0, 102, 204, 0.25);
            box-shadow: 0 6px 20px rgba(0, 102, 204, 0.35);
        }
        
        .background-logo .brand-name {
            font-size: 38px;
            font-weight: 800;
            color: #0066cc;
            text-align: center;
            letter-spacing: -2px;
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 24px;
        }
        
        .logo-image {
            max-width: 80px;
            height: auto;
            margin-bottom: 8px;
            border-radius: 8px;
        }
        
        .brand-name {
            font-size: 20px;
            font-weight: 700;
            color: #0066cc;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }
        
        h1 {
            color: #1a1a1a;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
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
            background: #0066cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background: #004499;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 102, 204, 0.3);
        }
        
        .btn-cancel {
            background: #0066cc;
            color: white;
        }
        
        .btn-cancel:hover {
            background: #004499;
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
            
            <form action="usuario" method="post" autocomplete="off">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>">
                
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required
                           value="<%= usuario.getNombre() %>"
                           autocomplete="off">
                </div>
                
                <div class="form-group">
                    <label for="correo">Correo:</label>
                    <input type="email" id="correo" name="correo" required
                           value="<%= usuario.getCorreo() %>"
                           autocomplete="off">
                </div>
                
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required
                           value="<%= usuario.getContrasena() %>"
                           autocomplete="new-password">
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
    
    <!-- Logo de fondo grande -->
    <div class="background-logo">
        <img src="images/WhatsApp Image 2026-04-07 at 10.59.53 AM.jpeg" alt="E-form Logo"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
        <div class="brand-name" style="display: none;">E-form</div>
    </div>
</body>
</html>
