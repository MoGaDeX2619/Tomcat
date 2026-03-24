<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario - EA04</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            font-weight: bold;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 500;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .invalid-feedback {
            display: block;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .search-box {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="fas fa-users-cog text-primary"></i> EA04 - Módulo CRUD
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-home"></i> Inicio
                </a>
                <a class="nav-link" href="crear-usuario.jsp">
                    <i class="fas fa-user-plus"></i> Crear Usuario
                </a>
                <a class="nav-link active" href="usuarios">
                    <i class="fas fa-list"></i> Listar Usuarios
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Buscador -->
        <div class="search-box">
            <div class="row">
                <div class="col-12">
                    <h5 class="mb-3">
                        <i class="fas fa-search me-2"></i>Buscar Usuario
                    </h5>
                    <form action="usuarios" method="GET" class="d-flex">
                        <input type="hidden" name="accion" value="buscar">
                        <input type="text" class="form-control me-2" name="termino" 
                               value="${param.termino}" placeholder="Buscar por nombre o apellido...">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i> Buscar
                        </button>
                        <a href="usuarios" class="btn btn-secondary ms-2">
                            <i class="fas fa-times"></i> Limpiar
                        </a>
                    </form>
                </div>
            </div>
        </div>

        <!-- Resultados de búsqueda -->
        <c:if test="${param.accion == 'buscar' and not empty termino}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fas fa-info-circle me-2"></i>
                Resultados para: <strong>${termino}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Lista de usuarios -->
        <c:if test="${empty usuarioEditar}">
            <div class="card">
                <div class="card-header text-center py-3">
                    <h4 class="mb-0">
                        <i class="fas fa-users me-2"></i>
                        Lista de Usuarios
                    </h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty usuarios}">
                            <div class="text-center py-4">
                                <i class="fas fa-user-slash fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">No se encontraron usuarios</h5>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${param.accion == 'buscar'}">
                                            No hay resultados para su búsqueda. Intente con otros términos.
                                        </c:when>
                                        <c:otherwise>
                                            No hay usuarios registrados. 
                                            <a href="crear-usuario.jsp" class="alert-link">Cree el primer usuario aquí</a>.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Email</th>
                                            <th>Teléfono</th>
                                            <th>Fecha Creación</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${usuarios}" var="usuario">
                                            <tr>
                                                <td>${usuario.id}</td>
                                                <td>${usuario.nombre} ${usuario.apellido}</td>
                                                <td>${usuario.email}</td>
                                                <td>${usuario.telefono}</td>
                                                <td>
                                                    <fmt:formatDate value="${usuario.fechaCreacion}" 
                                                                   pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <a href="usuarios?accion=editar&id=${usuario.id}" 
                                                       class="btn btn-sm btn-primary">
                                                        <i class="fas fa-edit"></i> Editar
                                                    </a>
                                                    <button onclick="confirmarEliminar(${usuario.id})" 
                                                            class="btn btn-sm btn-danger">
                                                        <i class="fas fa-trash"></i> Eliminar
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>

        <!-- Formulario de edición -->
        <c:if test="${not empty usuarioEditar}">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h4 class="mb-0">
                                <i class="fas fa-user-edit me-2"></i>
                                Editar Usuario #${usuarioEditar.id}
                            </h4>
                        </div>
                        <div class="card-body p-4">
                            <!-- Mensajes de error/éxito -->
                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-${mensajeTipo == 'error' ? 'danger' : 'success'} alert-dismissible fade show" role="alert">
                                    <i class="fas fa-${mensajeTipo == 'error' ? 'exclamation-triangle' : 'check-circle'} me-2"></i>
                                    ${mensaje}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Errores de validación -->
                            <c:if test="${not empty errores}">
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <h6><i class="fas fa-exclamation-triangle me-2"></i>Por favor corrija los siguientes errores:</h6>
                                    <ul class="mb-0">
                                        <c:forEach items="${errores}" var="error">
                                            <li>${error}</li>
                                        </c:forEach>
                                    </ul>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="usuarios" method="POST" id="formularioEditar">
                                <input type="hidden" name="accion" value="actualizar">
                                <input type="hidden" name="id" value="${usuarioEditar.id}">
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="nombre" class="form-label">
                                            <i class="fas fa-user me-1"></i>Nombre *
                                        </label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" 
                                               value="${usuarioEditar.nombre}" required maxlength="50"
                                               placeholder="Ingrese su nombre">
                                        <div class="invalid-feedback" id="nombreError"></div>
                                        <small class="text-muted">Mínimo 3 caracteres, máximo 50</small>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="apellido" class="form-label">
                                            <i class="fas fa-user me-1"></i>Apellido *
                                        </label>
                                        <input type="text" class="form-control" id="apellido" name="apellido" 
                                               value="${usuarioEditar.apellido}" required maxlength="50"
                                               placeholder="Ingrese su apellido">
                                        <div class="invalid-feedback" id="apellidoError"></div>
                                        <small class="text-muted">Mínimo 3 caracteres, máximo 50</small>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email *
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${usuarioEditar.email}" required maxlength="100"
                                           placeholder="ejemplo@correo.com">
                                    <div class="invalid-feedback" id="emailError"></div>
                                    <small class="text-muted">Ingrese un email válido</small>
                                </div>

                                <div class="mb-3">
                                    <label for="telefono" class="form-label">
                                        <i class="fas fa-phone me-1"></i>Teléfono *
                                    </label>
                                    <input type="tel" class="form-control" id="telefono" name="telefono" 
                                           value="${usuarioEditar.telefono}" required maxlength="15"
                                           placeholder="12345678">
                                    <div class="invalid-feedback" id="telefonoError"></div>
                                    <small class="text-muted">Solo números, entre 8 y 15 dígitos</small>
                                </div>

                                <div class="mb-4">
                                    <label for="direccion" class="form-label">
                                        <i class="fas fa-map-marker-alt me-1"></i>Dirección *
                                    </label>
                                    <textarea class="form-control" id="direccion" name="direccion" 
                                              rows="3" required maxlength="200"
                                              placeholder="Ingrese su dirección completa">${usuarioEditar.direccion}</textarea>
                                    <div class="invalid-feedback" id="direccionError"></div>
                                    <small class="text-muted">Mínimo 5 caracteres, máximo 200</small>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>
                                            Creado: <fmt:formatDate value="${usuarioEditar.fechaCreacion}" 
                                                                   pattern="dd/MM/yyyy HH:mm"/>
                                        </small>
                                    </div>
                                    <div class="col-md-6 text-end">
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>
                                            Actualizado: <fmt:formatDate value="${usuarioEditar.fechaActualizacion}" 
                                                                        pattern="dd/MM/yyyy HH:mm"/>
                                        </small>
                                    </div>
                                </div>

                                <hr>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <a href="usuarios" class="btn btn-secondary me-md-2">
                                        <i class="fas fa-arrow-left me-1"></i>Volver a Lista
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-1"></i>Actualizar Usuario
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="text-white text-center py-3 mt-5" style="background: rgba(0,0,0,0.2);">
        <div class="container">
            <p class="mb-0">© 2024 - EA04 Módulo Web CRUD | Desarrollado para evidencia de aprendizaje</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validación del lado del cliente
        document.getElementById('formularioEditar')?.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validar nombre
            const nombre = document.getElementById('nombre').value.trim();
            if (nombre.length < 3 || nombre.length > 50) {
                document.getElementById('nombreError').textContent = 'El nombre debe tener entre 3 y 50 caracteres';
                document.getElementById('nombre').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('nombre').classList.remove('is-invalid');
            }
            
            // Validar apellido
            const apellido = document.getElementById('apellido').value.trim();
            if (apellido.length < 3 || apellido.length > 50) {
                document.getElementById('apellidoError').textContent = 'El apellido debe tener entre 3 y 50 caracteres';
                document.getElementById('apellido').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('apellido').classList.remove('is-invalid');
            }
            
            // Validar email
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('emailError').textContent = 'El formato del email no es válido';
                document.getElementById('email').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('email').classList.remove('is-invalid');
            }
            
            // Validar teléfono
            const telefono = document.getElementById('telefono').value.trim();
            const telefonoRegex = /^[0-9]{8,15}$/;
            if (!telefonoRegex.test(telefono)) {
                document.getElementById('telefonoError').textContent = 'El teléfono debe contener solo números y tener entre 8 y 15 dígitos';
                document.getElementById('telefono').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('telefono').classList.remove('is-invalid');
            }
            
            // Validar dirección
            const direccion = document.getElementById('direccion').value.trim();
            if (direccion.length < 5 || direccion.length > 200) {
                document.getElementById('direccionError').textContent = 'La dirección debe tener entre 5 y 200 caracteres';
                document.getElementById('direccion').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('direccion').classList.remove('is-invalid');
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
        
        // Limpiar errores al escribir
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('is-invalid');
                const errorDiv = document.getElementById(this.id + 'Error');
                if (errorDiv) {
                    errorDiv.textContent = '';
                }
            });
        });
        
        // Confirmar eliminación
        function confirmarEliminar(id) {
            if (confirm('¿Está seguro de que desea eliminar este usuario? Esta acción no se puede deshacer.')) {
                window.location.href = 'usuarios?accion=eliminar&id=' + id;
            }
        }
    </script>
</body>
</html>
