<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario</title>
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
            max-width: 500px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        h1 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .subtitle {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
            font-size: 14px;
        }
        
        input[type="text"], input[type="email"], input[type="password"], input[type="number"], select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }
        
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus, 
        input[type="number"]:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        input::placeholder {
            color: #95a5a6;
        }
        
        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 14px 20px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
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
            background: #ecf0f1;
            color: #7f8c8d;
        }
        
        .btn-secondary:hover {
            background: #d5dbdd;
        }
        
        .error {
            background: #fee;
            border: 1px solid #fcc;
            color: #c33;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
        }
        
        .error ul {
            margin: 10px 0 0 20px;
        }
        
        .error li {
            margin-bottom: 5px;
        }
        
        /* Mensajes de validación en tiempo real */
        .mensaje-validacion {
            font-size: 13px;
            margin-top: 8px;
            padding: 10px 12px;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .mensaje-error {
            display: block !important;
            background-color: #dc3545;
            color: white;
            border: 1px solid #dc3545;
        }
        
        .mensaje-exito {
            display: block !important;
            background-color: #28a745;
            color: white;
            border: 1px solid #28a745;
        }
        
        .input-error {
            border-color: #dc3545 !important;
            background-color: #fff5f5 !important;
        }
        
        .input-exito {
            border-color: #28a745 !important;
            background-color: #f0fff4 !important;
        }
        
        small {
            color: #6c757d;
            font-size: 12px;
        }
        
        @media (max-width: 600px) {
            .container {
                margin: 20px;
                padding: 25px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Nuevo Usuario</h1>
            <div class="subtitle">Completa el formulario para agregar un nuevo usuario al sistema</div>
        </div>
        
        <%-- Mostrar errores de validación --%>
        <% if (request.getAttribute("errores") != null) { %>
            <div class="error">
                <strong>Por favor corrige los siguientes errores:</strong>
                <ul>
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
            
            <div class="form-row">
                <div class="form-group">
                    <label for="idUsuario">ID de Usuario:</label>
                    <input type="number" id="idUsuario" name="idUsuario" 
                           placeholder="Opcional" min="1">
                </div>
                
                <div class="form-group">
                    <label for="nombre">Nombre Completo:</label>
                    <input type="text" id="nombre" name="nombre" required
                           placeholder="Ej: Juan Pérez"
                           value="<%= request.getAttribute("usuario") != null ? 
                                   ((Usuario)request.getAttribute("usuario")).getNombre() : "" %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="correo">Correo Electrónico:</label>
                <input type="email" id="correo" name="correo" required
                       placeholder="ejemplo@correo.com"
                       value="<%= request.getAttribute("usuario") != null ? 
                               ((Usuario)request.getAttribute("usuario")).getCorreo() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="contrasena">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" required
                       placeholder="Mayúscula, número y símbolo"
                       autocomplete="new-password"
                       onblur="validarContrasena(this.value)"
                       oninput="limpiarErrorContrasena()">
                <div id="contrasenaMensaje" class="mensaje-validacion" style="display: none; font-size: 13px; margin-top: 8px; padding: 8px 12px; border-radius: 6px;"></div>
                <small style="color: #6c757d; font-size: 12px; display: block; margin-top: 5px;">
                    Debe contener: 1 mayúscula, 1 número y 1 símbolo (ej: @#$%&*)
                </small>
            </div>
            
            <div class="form-group">
                <label for="rol">Rol del Usuario:</label>
                <select id="rol" name="rol" required>
                    <option value="">Selecciona un rol...</option>
                    <option value="ADMIN" 
                            <%= request.getAttribute("usuario") != null && 
                               "ADMIN".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Administrador</option>
                    <option value="USER" 
                            <%= request.getAttribute("usuario") != null && 
                               "USER".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Usuario Regular</option>
                    <option value="MODERATOR" 
                            <%= request.getAttribute("usuario") != null && 
                               "MODERATOR".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Moderador</option>
                </select>
            </div>
            
            <div class="buttons">
                <button type="submit" class="btn btn-primary">Guardar Usuario</button>
                <a href="index.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
    
    <script>
        // Validación de contraseña en tiempo real
        function validarContrasena(contrasena) {
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            const contrasenaInput = document.getElementById('contrasena');
            
            // Limpiar clases anteriores
            contrasenaMensaje.className = 'mensaje-validacion';
            contrasenaInput.className = '';
            contrasenaMensaje.style.display = 'none';
            
            // Si el campo está vacío, no validar
            if (!contrasena || contrasena.trim() === '') {
                return;
            }
            
            // Validar requisitos
            const errores = [];
            
            if (!/[A-Z]/.test(contrasena)) {
                errores.push('una mayúscula');
            }
            
            if (!/[0-9]/.test(contrasena)) {
                errores.push('un número');
            }
            
            if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(contrasena)) {
                errores.push('un símbolo (!@#$%^&*)');
            }
            
            if (contrasena.length < 6) {
                errores.push('mínimo 6 caracteres');
            }
            
            if (errores.length > 0) {
                const mensaje = '⚠️ Falta: ' + errores.join(', ');
                mostrarErrorContrasena(mensaje);
            } else {
                mostrarExitoContrasena('✅ Contraseña válida');
            }
        }
        
        function mostrarErrorContrasena(mensaje) {
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            const contrasenaInput = document.getElementById('contrasena');
            
            contrasenaMensaje.textContent = mensaje;
            contrasenaMensaje.className = 'mensaje-validacion mensaje-error';
            contrasenaInput.className = 'input-error';
        }
        
        function mostrarExitoContrasena(mensaje) {
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            const contrasenaInput = document.getElementById('contrasena');
            
            contrasenaMensaje.textContent = mensaje;
            contrasenaMensaje.className = 'mensaje-validacion mensaje-exito';
            contrasenaInput.className = 'input-exito';
        }
        
        function limpiarErrorContrasena() {
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            const contrasenaInput = document.getElementById('contrasena');
            const valor = contrasenaInput.value.trim();
            
            if (valor === '') {
                contrasenaMensaje.style.display = 'none';
                contrasenaMensaje.className = 'mensaje-validacion';
                contrasenaInput.className = '';
            }
        }
        
        // Prevenir envío si hay errores de contraseña
        document.querySelector('form').addEventListener('submit', function(e) {
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            const contrasenaError = contrasenaMensaje.classList.contains('mensaje-error');
            
            if (contrasenaError) {
                e.preventDefault();
                alert('⚠️ Por favor, corrige los errores de la contraseña antes de continuar.');
            }
        });
    </script>
</body>
</html>
