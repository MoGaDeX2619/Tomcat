<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.modelo.Usuario" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios | E-form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f7ff 0%, #e6f2ff 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.15); /* Ultra transparente */
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
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
            width: 380px;
            height: 380px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid rgba(0, 102, 204, 0.2);
            box-shadow: 0 10px 40px rgba(0, 102, 204, 0.3);
        }
        
        .background-logo .brand-name {
            font-size: 52px;
            font-weight: 800;
            color: #0066cc;
            text-align: center;
            letter-spacing: -2px;
        }
        
        .header {
            background: linear-gradient(135deg, #0066cc 0%, #004499 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .logo-container {
            margin-bottom: 20px;
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
            color: white;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
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
            background: linear-gradient(135deg, #0066cc 0%, #004499 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 102, 204, 0.3);
        }
        
        .btn-secondary {
            background: #0066cc;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #004499;
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
            background: #0066cc;
            color: white;
        }
        
        .btn-edit:hover {
            background: #004499;
        }
        
        .btn-delete {
            background: #0066cc;
            color: white;
        }
        
        .btn-delete:hover {
            background: #004499;
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
            <h1>Usuarios Registrados</h1>
            <div class="subtitle">Gestiona todas las cuentas del sistema</div>
        </div>
        
        <div class="actions-bar">
            <a href="index.jsp" class="btn btn-secondary">
                ← Menú Principal
            </a>
            <a href="crear.jsp" class="btn btn-primary">
                + Agregar Usuario
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
                        <h3 style="color: #000000; font-size: 24px; font-weight: bold;"><strong>No hay usuarios aún</strong></h3>
                        <p style="color: #000000; font-size: 18px; font-weight: bold;"><strong>Empieza agregando la primera cuenta al sistema</strong></p>
                        <a href="crear.jsp" class="btn btn-primary">Crear Primer Usuario</a>
                    </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function confirmarEliminacion(id, nombre) {
            if (confirm('¿Quieres eliminar a "' + nombre + '"?\n\nEsta acción no se puede revertir.')) {
                window.location.href = 'usuario?accion=eliminar&id=' + id;
            }
        }
    </script>
    
    <!-- Logo de fondo grande -->
    <div class="background-logo">
        <img src="images/WhatsApp Image 2026-04-07 at 10.59.53 AM.jpeg" alt="E-form Logo"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
        <div class="brand-name" style="display: none;">E-form</div>
    </div>
</body>
</html>
