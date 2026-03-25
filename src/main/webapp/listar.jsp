<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios del Sistema</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .header .subtitle {
            opacity: 0.9;
            font-size: 16px;
        }
        
        .actions-bar {
            padding: 25px 30px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .content {
            padding: 30px;
        }
        
        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .message.exito {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #e9ecef;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f8f9fa;
        }
        
        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e9ecef;
        }
        
        td {
            padding: 18px 15px;
            border-bottom: 1px solid #f1f3f4;
            color: #495057;
            font-size: 14px;
        }
        
        tbody tr {
            transition: background-color 0.2s ease;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .user-id {
            font-weight: 600;
            color: #667eea;
        }
        
        .user-name {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .user-email {
            color: #6c757d;
            font-size: 13px;
        }
        
        .role-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .role-admin {
            background: #dc3545;
            color: white;
        }
        
        .role-user {
            background: #28a745;
            color: white;
        }
        
        .role-moderator {
            background: #ffc107;
            color: #212529;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-sm {
            padding: 8px 12px;
            font-size: 12px;
            border-radius: 6px;
        }
        
        .btn-edit {
            background: #ffc107;
            color: #212529;
        }
        
        .btn-edit:hover {
            background: #e0a800;
        }
        
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
        }
        
        .empty-state .icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #495057;
        }
        
        .empty-state p {
            font-size: 16px;
            margin-bottom: 25px;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 10px;
            }
            
            .header {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 24px;
            }
            
            .actions-bar {
                padding: 20px;
                flex-direction: column;
                align-items: stretch;
            }
            
            .content {
                padding: 20px;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 600px;
            }
            
            th, td {
                padding: 12px 8px;
                font-size: 12px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Usuarios del Sistema</h1>
            <div class="subtitle">Gestiona todos los usuarios registrados en la plataforma</div>
        </div>
        
        <div class="actions-bar">
            <a href="index.jsp" class="btn btn-secondary">
                ← Inicio
            </a>
            <a href="crear.jsp" class="btn btn-primary">
                + Nuevo Usuario
            </a>
        </div>
        
        <div class="content">
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
                <div class="table-container">
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
                                    <td class="user-id">#<%= usuario.getIdUsuario() %></td>
                                    <td class="user-name"><%= usuario.getNombre() %></td>
                                    <td class="user-email"><%= usuario.getCorreo() %></td>
                                    <td>
                                        <% 
                                        String rol = usuario.getRol();
                                        String badgeClass = "";
                                        String rolText = "";
                                        switch (rol) {
                                            case "ADMIN":
                                                badgeClass = "role-admin";
                                                rolText = "Administrador";
                                                break;
                                            case "USER":
                                                badgeClass = "role-user";
                                                rolText = "Usuario";
                                                break;
                                            case "MODERATOR":
                                                badgeClass = "role-moderator";
                                                rolText = "Moderador";
                                                break;
                                            default:
                                                badgeClass = "role-user";
                                                rolText = rol;
                                        }
                                        %>
                                        <span class="role-badge <%= badgeClass %>"><%= rolText %></span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="usuario?accion=editar&id=<%= usuario.getIdUsuario() %>" 
                                               class="btn btn-sm btn-edit">Editar</a>
                                            <% 
                                        String nombreSeguro = usuario.getNombre().replace("'", "\\'");
                                        %>
                                        <a href="javascript:void(0)" 
                                               onclick="confirmarEliminacion(<%= usuario.getIdUsuario() %>, '<%= nombreSeguro %>')"
                                               class="btn btn-sm btn-delete">Eliminar</a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <h3>No hay usuarios registrados</h3>
                    <p>Comienza agregando tu primer usuario al sistema</p>
                    <a href="crear.jsp" class="btn btn-primary">Crear Primer Usuario</a>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function confirmarEliminacion(id, nombre) {
            if (confirm('¿Estás seguro de que deseas eliminar a "' + nombre + '"?\n\nEsta acción no se puede deshacer.')) {
                window.location.href = 'usuario?accion=eliminar&id=' + id;
            }
        }
    </script>
</body>
</html>
