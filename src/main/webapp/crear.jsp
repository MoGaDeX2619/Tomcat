<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Nuevo Usuario</title>
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
    </style>
</head>
<body>
    <div class="container">
        <h1>➕ Crear Nuevo Usuario</h1>
        
        <%-- Mostrar errores de validación --%>
        <% if (request.getAttribute("errores") != null) { %>
            <div class="error">
                <strong>Por favor corrija los siguientes errores:</strong>
                <ul class="error-list">
                    <% 
                    List<String> errores = (List<String>) request.getAttribute("errores");
                    for (String error : errores) { 
                    %>
                        <li><%= error %></li>
                    <% } %>
                </ul>
            </div>
        <% } %>
        
        <form action="usuario" method="post">
            <input type="hidden" name="accion" value="crear">
            
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required
                       value="<%= request.getAttribute("usuario") != null ? 
                               ((Usuario)request.getAttribute("usuario")).getNombre() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="correo">Correo electrónico:</label>
                <input type="email" id="correo" name="correo" required
                       value="<%= request.getAttribute("usuario") != null ? 
                               ((Usuario)request.getAttribute("usuario")).getCorreo() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="contrasena">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" required
                       value="<%= request.getAttribute("usuario") != null ? 
                               ((Usuario)request.getAttribute("usuario")).getContrasena() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="rol">Rol:</label>
                <select id="rol" name="rol" required>
                    <option value="">Seleccione un rol...</option>
                    <option value="ADMIN" 
                            <%= request.getAttribute("usuario") != null && 
                               "ADMIN".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Administrador</option>
                    <option value="USER" 
                            <%= request.getAttribute("usuario") != null && 
                               "USER".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Usuario</option>
                    <option value="MODERATOR" 
                            <%= request.getAttribute("usuario") != null && 
                               "MODERATOR".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Moderador</option>
                </select>
            </div>
            
            <div class="buttons">
                <button type="submit" class="btn">💾 Guardar Usuario</button>
                <a href="index.jsp" class="btn btn-cancel">🔙 Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
