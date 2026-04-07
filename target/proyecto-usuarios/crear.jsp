<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario | E-form</title>
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
            max-width: 500px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.15); /* Ultra transparente */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 102, 204, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.1);
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
            /* Opción alternativa: margin-top: -20px; */
        }
        
        .background-logo img {
            width: 320px;
            height: 320px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid rgba(0, 102, 204, 0.25);
            box-shadow: 0 6px 24px rgba(0, 102, 204, 0.35);
        }
        
        .background-logo .brand-name {
            font-size: 42px;
            font-weight: 800;
            color: #37536f;
            text-align: center;
            letter-spacing: -2px;
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 32px;
        }
        
        .logo-image {
            max-width: 100px;
            height: auto;
            margin-bottom: 12px;
            border-radius: 8px;
        }
        
        .brand-name {
            font-size: 24px;
            font-weight: 700;
            color: #0066cc;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
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
            gap: 12px;
            justify-content: flex-end;
            margin-top: 32px;
        }
        
        .info-note {
            margin-top: 8px;
            padding: 8px 12px;
            background-color: #e3f2fd;
            border-radius: 6px;
            text-align: center;
        }
        
        .info-note small {
            color: #1976d2;
            font-weight: 500;
        }
        
        .btn {
            background: #0066cc;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn:hover {
            background: #004499;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .btn-secondary {
            background: #0066cc;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #004499;
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
            box-shadow: 0 0 0 2px rgba(40, 167, 69, 0.25) !important;
        }
        
        .date-input-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .date-input-container input[type="date"] {
            padding-right: 40px;
            font-family: inherit;
            font-size: 16px;
        }
        
        .date-input-container .date-icon {
            position: absolute;
            right: 12px;
            pointer-events: none;
            opacity: 0.5;
            font-size: 16px;
        }
        
        /* Estilo para navegadores que no soportan placeholder en date */
        input[type="date"]::-webkit-datetime-edit-text {
            color: #6c757d;
        }
        
        input[type="date"]::-webkit-datetime-edit-year-field {
            color: #495057;
        }
        
        input[type="date"]::-webkit-datetime-edit-month-field {
            color: #495057;
        }
        
        input[type="date"]::-webkit-datetime-edit-day-field {
            color: #495057;
        }
        
        input[type="date"]:not(:valid)::-webkit-datetime-edit-text {
            color: #6c757d;
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
            <h1>Agregar Nuevo Usuario</h1>
            <div class="subtitle">Completa los datos para registrar una nueva cuenta en el sistema</div>
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
        
        <form action="usuario" method="post" autocomplete="off">
            <input type="hidden" name="accion" value="crear">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="nombre">Nombre Completo:</label>
                    <input type="text" id="nombre" name="nombre" required
                           placeholder="Escribe el nombre completo"
                           autocomplete="off"
                           value="<%= request.getAttribute("usuario") != null ? 
                                   ((Usuario)request.getAttribute("usuario")).getNombre() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="cedula">Cédula:</label>
                    <input type="text" id="cedula" name="cedula" required
                           placeholder="Ej: 00123456789"
                           maxlength="20"
                           autocomplete="off"
                           onblur="validarCedula(this.value)"
                           oninput="limpiarErrorCedula()">
                    <div id="cedulaMensaje" class="mensaje-validacion" style="display: none; font-size: 13px; margin-top: 8px; padding: 8px 12px; border-radius: 6px;"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="correo">Correo Electrónico:</label>
                <input type="email" id="correo" name="correo" required
                       placeholder="tu.correo@ejemplo.com"
                       autocomplete="off"
                       value="<%= request.getAttribute("usuario") != null ? 
                               ((Usuario)request.getAttribute("usuario")).getCorreo() : "" %>">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required
                           placeholder="Crea una contraseña segura"
                           autocomplete="new-password"
                           onblur="validarContrasena(this.value)"
                           oninput="limpiarErrorContrasena()">
                    <div id="contrasenaMensaje" class="mensaje-validacion" style="display: none; font-size: 13px; margin-top: 8px; padding: 8px 12px; border-radius: 6px;"></div>
                    <small style="color: #6c757d; font-size: 12px; display: block; margin-top: 5px;">
                        Usa: 1 mayúscula, 1 número y 1 símbolo (!@#$%^&*)
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                    <div class="date-input-container">
                        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required
                               max="<%= java.time.LocalDate.now() %>"
                               autocomplete="off"
                               placeholder="DD/MM/YYYY"
                               onblur="validarFechaNacimiento(this.value)"
                               oninput="limpiarErrorFecha()">
                        <div class="date-icon">📅</div>
                    </div>
                    <div id="fechaMensaje" class="mensaje-validacion" style="display: none; font-size: 13px; margin-top: 8px; padding: 8px 12px; border-radius: 6px;"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="rol">Tipo de Usuario:</label>
                <select id="rol" name="rol" required>
                    <option value="">Elige el tipo de usuario...</option>
                    <option value="ADMIN" 
                            <%= request.getAttribute("usuario") != null && 
                               "ADMIN".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Administrador</option>
                    <option value="USER" 
                            <%= request.getAttribute("usuario") != null && 
                               "USER".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Usuario Normal</option>
                    <option value="MODERATOR" 
                            <%= request.getAttribute("usuario") != null && 
                               "MODERATOR".equals(((Usuario)request.getAttribute("usuario")).getRol()) ? 
                               "selected" : "" %>>Moderador</option>
                </select>
            </div>
            
            <div class="buttons">
                <button type="submit" class="btn btn-primary">Crear Usuario</button>
                <a href="index.jsp" class="btn btn-secondary">Volver al Inicio</a>
            </div>
        </form>
    </div>
    
    <!-- Logo de fondo grande -->
    <div class="background-logo">
        <img src="images/WhatsApp Image 2026-04-07 at 10.59.53 AM.jpeg" alt="E-form Logo"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
        <div class="brand-name" style="display: none;">E-form</div>
    </div>
    
    <script>
        // Validación de cédula en tiempo real
        function validarCedula(cedula) {
            const cedulaMensaje = document.getElementById('cedulaMensaje');
            const cedulaInput = document.getElementById('cedula');
            
            // Limpiar clases anteriores
            cedulaMensaje.className = 'mensaje-validacion';
            cedulaInput.className = '';
            cedulaMensaje.style.display = 'none';
            
            // Si el campo está vacío, no validar
            if (!cedula || cedula.trim() === '') {
                return;
            }
            
            // Limpiar cédula (solo números)
            const cedulaLimpia = cedula.replace(/[^0-9]/g, '');
            
            // Validar longitud mínima
            if (cedulaLimpia.length < 4) {
                mostrarErrorCedula('La cédula debe tener al menos 4 dígitos');
                return;
            }
            
            if (cedulaLimpia.length > 20) {
                mostrarErrorCedula('La cédula no puede tener más de 20 dígitos');
                return;
            }
            
            // Si pasa todas las validaciones
            mostrarExitoCedula('✅ Cédula válida');
        }
        
        function mostrarErrorCedula(mensaje) {
            const cedulaMensaje = document.getElementById('cedulaMensaje');
            const cedulaInput = document.getElementById('cedula');
            
            cedulaMensaje.textContent = mensaje;
            cedulaMensaje.className = 'mensaje-validacion mensaje-error';
            cedulaInput.className = 'input-error';
        }
        
        function mostrarExitoCedula(mensaje) {
            const cedulaMensaje = document.getElementById('cedulaMensaje');
            const cedulaInput = document.getElementById('cedula');
            
            cedulaMensaje.textContent = mensaje;
            cedulaMensaje.className = 'mensaje-validacion mensaje-exito';
            cedulaInput.className = 'input-exito';
        }
        
        function limpiarErrorCedula() {
            const cedulaMensaje = document.getElementById('cedulaMensaje');
            const cedulaInput = document.getElementById('cedula');
            const valor = cedulaInput.value.trim();
            
            if (valor === '') {
                cedulaMensaje.style.display = 'none';
                cedulaMensaje.className = 'mensaje-validacion';
                cedulaInput.className = '';
            }
        }
        
        // Validación de fecha de nacimiento en tiempo real
        function validarFechaNacimiento(fecha) {
            const fechaMensaje = document.getElementById('fechaMensaje');
            const fechaInput = document.getElementById('fechaNacimiento');
            
            // Limpiar clases anteriores
            fechaMensaje.className = 'mensaje-validacion';
            fechaInput.className = '';
            fechaMensaje.style.display = 'none';
            
            // Si el campo está vacío, no validar
            if (!fecha) {
                return;
            }
            
            const fechaSeleccionada = new Date(fecha);
            const hoy = new Date();
            const fechaMinima = new Date('1900-01-01');
            
            // Validar que no sea futura
            if (fechaSeleccionada > hoy) {
                mostrarErrorFecha('La fecha no puede ser futura');
                return;
            }
            
            // Validar que no sea muy antigua
            if (fechaSeleccionada < fechaMinima) {
                mostrarErrorFecha('La fecha debe ser posterior a 1900');
                return;
            }
            
            // Calcular edad
            const edad = Math.floor((hoy - fechaSeleccionada) / (365.25 * 24 * 60 * 60 * 1000));
            
            // Si pasa todas las validaciones
            mostrarExitoFecha('✅ Fecha válida (Edad: ' + edad + ' años)');
        }
        
        function mostrarErrorFecha(mensaje) {
            const fechaMensaje = document.getElementById('fechaMensaje');
            const fechaInput = document.getElementById('fechaNacimiento');
            
            fechaMensaje.textContent = mensaje;
            fechaMensaje.className = 'mensaje-validacion mensaje-error';
            fechaInput.className = 'input-error';
        }
        
        function mostrarExitoFecha(mensaje) {
            const fechaMensaje = document.getElementById('fechaMensaje');
            const fechaInput = document.getElementById('fechaNacimiento');
            
            fechaMensaje.textContent = mensaje;
            fechaMensaje.className = 'mensaje-validacion mensaje-exito';
            fechaInput.className = 'input-exito';
        }
        
        function limpiarErrorFecha() {
            const fechaMensaje = document.getElementById('fechaMensaje');
            const fechaInput = document.getElementById('fechaNacimiento');
            
            if (!fechaInput.value) {
                fechaMensaje.style.display = 'none';
                fechaMensaje.className = 'mensaje-validacion';
                fechaInput.className = '';
            }
        }
        
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
                const mensaje = 'Te falta: ' + errores.join(', ');
                mostrarErrorContrasena(mensaje);
            } else {
                mostrarExitoContrasena('¡Contraseña lista!');
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
        
        // Prevenir envío si hay errores
        document.querySelector('form').addEventListener('submit', function(e) {
            const cedulaMensaje = document.getElementById('cedulaMensaje');
            const fechaMensaje = document.getElementById('fechaMensaje');
            const contrasenaMensaje = document.getElementById('contrasenaMensaje');
            
            const cedulaError = cedulaMensaje.classList.contains('mensaje-error');
            const fechaError = fechaMensaje.classList.contains('mensaje-error');
            const contrasenaError = contrasenaMensaje.classList.contains('mensaje-error');
            
            if (cedulaError || fechaError || contrasenaError) {
                e.preventDefault();
                alert('Revisa los campos marcados en rojo antes de continuar.');
            }
        });
    </script>
</body>
</html>
