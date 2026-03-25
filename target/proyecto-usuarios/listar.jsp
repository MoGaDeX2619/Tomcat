<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
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
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            gap: 5px;
        }
        .actions a {
            padding: 6px 12px;
            font-size: 12px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
        .message.exito {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        .empty-state h3 {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 Lista de Usuarios</h1>
        
        <div class="header">
            <a href="index.jsp" class="btn btn-secondary">🏠 Inicio</a>
            <a href="crear.jsp" class="btn btn-success">➕ Crear Nuevo Usuario</a>
        </div>
        
        <%-- Mostrar mensajes --%>
        <% if (request.getAttribute("mensaje") != null) { %>
            <div class="message <%= request.getAttribute("tipoMensaje") %>">
                <%= request.getAttribute("mensaje") %>
            </div>
        <% } %>
        
        <% 
        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
        if (usuarios != null && !usuarios.isEmpty()) { 
        %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Usuario usuario : usuarios) { %>
                        <tr>
                            <td><%= usuario.getIdUsuario() %></td>
                            <td><%= usuario.getNombre() %></td>
                            <td><%= usuario.getCorreo() %></td>
                            <td>
                                <% 
                                String rol = usuario.getRol();
                                String rolDisplay = "";
                                switch (rol) {
                                    case "ADMIN":
                                        rolDisplay = "👑 Administrador";
                                        break;
                                    case "USER":
                                        rolDisplay = "👤 Usuario";
                                        break;
                                    case "MODERATOR":
                                        rolDisplay = "🛡️ Moderador";
                                        break;
                                    default:
                                        rolDisplay = rol;
                                }
                                %>
                                <%= rolDisplay %>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="usuario?accion=editar&id=<%= usuario.getIdUsuario() %>" 
                                       class="btn btn-warning">✏️ Editar</a>
                                    <a href="javascript:void(0)" 
                                       onclick="confirmarEliminacion(<%= usuario.getIdUsuario() %>, '<%= usuario.getNombre() %>')"
                                       class="btn btn-danger">🗑️ Eliminar</a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="empty-state">
                <h3>📭 No hay usuarios registrados</h3>
                <p>¡Comienza creando tu primer usuario!</p>
                <a href="crear.jsp" class="btn btn-success">➕ Crear Primer Usuario</a>
            </div>
        <% } %>
    </div>
    
    <script>
        function confirmarEliminacion(id, nombre) {
            if (confirm('¿Estás seguro de que deseas eliminar al usuario "' + nombre + '"?\n\nEsta acción no se puede deshacer.')) {
                window.location.href = 'usuario?accion=eliminar&id=' + id;
            }
        }
    </script>
</body>
</html>
