<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EA04 - Módulo Web CRUD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0 !important;
            text-align: center;
            padding: 2rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .btn-outline-primary {
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-outline-primary:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: transparent;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .feature-card {
            border: 1px solid rgba(102, 126, 234, 0.2);
            border-radius: 15px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
            border-color: #667eea;
        }
        .feature-icon {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 1rem;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }
        .navbar-brand {
            color: white !important;
            font-weight: bold;
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            transition: color 0.3s ease;
        }
        .nav-link:hover, .nav-link.active {
            color: white !important;
        }
        .stats-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            color: white;
        }
        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="fas fa-users-cog me-2"></i>EA04 - Módulo CRUD
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" href="index.jsp">
                    <i class="fas fa-home me-1"></i> Inicio
                </a>
                <a class="nav-link" href="crear-usuario.jsp">
                    <i class="fas fa-user-plus me-1"></i> Crear Usuario
                </a>
                <a class="nav-link" href="usuarios">
                    <i class="fas fa-list me-1"></i> Listar Usuarios
                </a>
            </div>
        </div>
    </nav>

    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <!-- Columna izquierda - Información principal -->
                <div class="col-lg-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h1 class="mb-3">
                                <i class="fas fa-code me-3"></i>
                                EA04 - Módulo Web CRUD
                            </h1>
                            <p class="lead mb-0">
                                Sistema de gestión de usuarios con servlets y JSP
                            </p>
                        </div>
                        <div class="card-body p-4">
                            <div class="mb-4">
                                <h4 class="text-primary mb-3">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Descripción del Proyecto
                                </h4>
                                <p class="text-muted">
                                    Este módulo web implementa un sistema completo de gestión de usuarios 
                                    utilizando tecnología Java EE con servlets y JSP. Cumple con los requisitos 
                                    de la actividad EA04, demostrando el manejo de operaciones CRUD, 
                                    validaciones y persistencia de datos.
                                </p>
                            </div>

                            <div class="mb-4">
                                <h5 class="text-primary mb-3">
                                    <i class="fas fa-cogs me-2"></i>
                                    Características Implementadas
                                </h5>
                                <ul class="list-unstyled">
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Operaciones CRUD completas</strong> - Crear, leer, actualizar y eliminar usuarios
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Validaciones en servidor y cliente</strong> - 3+ reglas de validación implementadas
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Manejo de métodos GET/POST</strong> - Gestión adecuada de peticiones HTTP
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Base de datos MySQL</strong> - Persistencia de datos con conexión JDBC
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Mensajes de usuario</strong> - Sistema de notificaciones éxito/error
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong>Interfaz moderna</strong> - Bootstrap 5 + Font Awesome
                                    </li>
                                </ul>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                <a href="crear-usuario.jsp" class="btn btn-primary me-md-2">
                                    <i class="fas fa-user-plus me-2"></i>
                                    Crear Nuevo Usuario
                                </a>
                                <a href="usuarios" class="btn btn-outline-primary">
                                    <i class="fas fa-list me-2"></i>
                                    Ver Todos los Usuarios
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Columna derecha - Características y estadísticas -->
                <div class="col-lg-6">
                    <div class="row g-3">
                        <!-- Características -->
                        <div class="col-12">
                            <h4 class="text-white text-center mb-3">
                                <i class="fas fa-star me-2"></i>
                                Funcionalidades Principales
                            </h4>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <div class="feature-card">
                                <div class="text-center">
                                    <i class="fas fa-user-plus feature-icon"></i>
                                    <h5>Formulario de Creación</h5>
                                    <p class="text-muted small mb-0">
                                        Formulario completo con validaciones para crear nuevos usuarios
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <div class="feature-card">
                                <div class="text-center">
                                    <i class="fas fa-edit feature-icon"></i>
                                    <h5>Formulario de Edición</h5>
                                    <p class="text-muted small mb-0">
                                        Edición de datos de usuarios con búsqueda integrada
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <div class="feature-card">
                                <div class="text-center">
                                    <i class="fas fa-search feature-icon"></i>
                                    <h5>Búsqueda de Usuarios</h5>
                                    <p class="text-muted small mb-0">
                                        Búsqueda por nombre y apellido con resultados en tiempo real
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <div class="feature-card">
                                <div class="text-center">
                                    <i class="fas fa-database feature-icon"></i>
                                    <h5>Persistencia</h5>
                                    <p class="text-muted small mb-0">
                                        Almacenamiento en base de datos MySQL con JDBC
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Estadísticas -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <h4 class="text-white text-center mb-3">
                                <i class="fas fa-chart-bar me-2"></i>
                                Tecnologías Utilizadas
                            </h4>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <i class="fab fa-java fa-2x mb-2"></i>
                                <div class="stats-number">Java EE</div>
                                <small>Servlets + JSP</small>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <i class="fas fa-database fa-2x mb-2"></i>
                                <div class="stats-number">MySQL</div>
                                <small>Base de datos</small>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <i class="fab fa-bootstrap fa-2x mb-2"></i>
                                <div class="stats-number">Bootstrap 5</div>
                                <small>UI Framework</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-white text-center py-4" style="background: rgba(0,0,0,0.3); margin-top: -100px;">
        <div class="container">
            <p class="mb-2">
                <i class="fas fa-graduation-cap me-2"></i>
                EA04 - Evidencia de Aprendizaje | Módulo Web CRUD
            </p>
            <p class="mb-0 small">
                Desarrollado con <i class="fas fa-heart text-danger"></i> para el proceso formativo
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animación de entrada
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.feature-card, .stats-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    card.style.transition = 'all 0.5s ease';
                    
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 100);
                }, index * 100);
            });
        });
    </script>
</body>
</html>
