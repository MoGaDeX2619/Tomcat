<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Control | Sistema de Usuarios</title>
    
    <style>
        /* -----------------------------------------------------------
           1. CSS Reset & Variables de Marca
           ----------------------------------------------------------- */
        :root {
            --brand-primary: #1d4ed8;       /* Azul Principal Corporativo */
            --brand-secondary: #e0f2fe;     /* Azul Claro de Acento */
            --text-on-dark: #ffffff;
            --text-main: #0f172a;           /* Gris Slate Profundo */
            --text-muted: #64748b;          /* Gris Slate Medio */
            --bg-page: #f1f5f9;             /* Fondo Suave */
            --card-white: #ffffff;
            --border-light: #e2e8f0;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* -----------------------------------------------------------
           2. Tipografía & Layout Base
           ----------------------------------------------------------- */
        body {
            /* Pila de fuentes de sistema para rendimiento y look nativo */
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
            background-color: var(--bg-page);
            color: var(--text-main);
            min-height: 100vh;
            display: grid;
            place-items: center; /* Centrado perfecto con Grid */
            padding: 24px;
        }

        .main-card {
            width: 100%;
            max-width: 480px;
            background: var(--card-white);
            padding: 48px;
            border-radius: 16px; /* Bordes menos exagerados, más serios */
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-light);
        }

        /* -----------------------------------------------------------
           3. Sección de Cabecera
           ----------------------------------------------------------- */
        .header-content {
            text-align: center;
            margin-bottom: 40px;
        }

        /* Indicador de versión, detalle de 'desarrollador' */
        .version-tag {
            display: inline-block;
            padding: 4px 8px;
            background: var(--brand-secondary);
            color: var(--brand-primary);
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 16px;
        }

        h1 {
            font-size: 28px;
            font-weight: 800; /* Peso extra para impacto */
            letter-spacing: -0.5px;
            margin-bottom: 12px;
        }

        .sub-description {
            color: var(--text-muted);
            font-size: 15px;
            line-height: 1.6;
        }

        /* -----------------------------------------------------------
           4. Navegación / Menú
           ----------------------------------------------------------- */
        .nav-stack {
            display: grid;
            gap: 12px;
        }

        /* El componente principal de botón/enlace */
        .nav-link {
            display: flex;
            align-items: center;
            padding: 16px;
            background: #ffffff;
            color: var(--text-main);
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            transition: border-color 0.2s, background-color 0.2s, box-shadow 0.2s;
            border: 1px solid var(--border-light);
            cursor: pointer;
        }

        /* Hover: cambio de color de borde y sombra suave */
        .nav-link:hover {
            border-color: var(--brand-primary);
            box-shadow: 0 4px 8px rgba(29, 78, 216, 0.1);
        }

        /* Botón con estilo primario (CTA) */
        .nav-link.primary {
            background-color: var(--brand-primary);
            color: var(--text-on-dark);
            border: none;
        }

        .nav-link.primary:hover {
            background-color: #1a365d; /* Un azul más oscuro */
            box-shadow: 0 8px 16px rgba(29, 78, 216, 0.2);
        }

        /* Contenedor del icono, look menos "emoji suelto" */
        .icon-container {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            margin-right: 16px;
            font-size: 16px;
            background: rgba(226, 232, 240, 0.8);
        }

        .primary .icon-container {
            background: rgba(255, 255, 255, 0.2);
        }

        /* Asegura que el texto ocupe el espacio */
        .label {
            flex: 1;
        }

        /* Detalle visual de la flecha */
        .chevron {
            font-family: monospace; /* Un chevron más "código" */
            font-size: 18px;
            opacity: 0.4;
            transition: transform 0.2s;
        }

        .nav-link:hover .chevron {
            transform: translateX(4px); /* Micro-interacción */
            opacity: 1;
        }

        /* -----------------------------------------------------------
           5. Pie de página
           ----------------------------------------------------------- */
        .page-footer {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--border-light);
            text-align: center;
        }

        .page-footer p {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 400;
        }

    </style>
</head>
<body>
    <div class="main-card">
        <div class="header-content">
            <span class="version-tag">Admin v0.9</span>
            <h1>Control de Usuarios</h1>
            <p class="sub-description">Portal administrativo para la gestión de cuentas y permisos.</p>
        </div>
        
        <nav class="nav-stack">
            <a href="usuario?accion=listar" class="nav-link primary">
                <div class="icon-container">👥</div>
                <div class="label">Directorio Completo</div>
                <span class="chevron">-></span>
            </a>
            
            <a href="crear.jsp" class="nav-link">
                <div class="icon-container">👤</div>
                <div class="label">Registrar Nuevo Perfil</div>
                <span class="chevron">-></span>
            </a>
        </nav>
        
        <div class="page-footer">
            <p>EA4 Tarea | Desarrollado por Nelson Diaz • 2026</p>
        </div>
    </div>
</body>
</html>