<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Control | E-form</title>
    
    <style>
        /* -----------------------------------------------------------
           1. CSS Reset & Variables de Marca
           ----------------------------------------------------------- */
        :root {
            --brand-primary: #0066cc;       /* Azul E-form Principal */
            --brand-secondary: #e6f2ff;     /* Azul Claro de Acento */
            --brand-dark: #004499;          /* Azul Oscuro */
            --brand-light: #f0f7ff;         /* Azul Muy Claro */
            --text-on-dark: #ffffff;
            --text-main: #1a1a1a;           /* Texto Principal */
            --text-muted: #666666;          /* Texto Secundario */
            --bg-page: #ffffff;             /* Fondo Blanco */
            --card-white: rgba(255, 255, 255, 0.15);
            --border-light: #e0e0e0;
            --shadow-md: 0 4px 6px -1px rgba(0, 102, 204, 0.1), 0 2px 4px -2px rgba(0, 102, 204, 0.1);
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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
            background-color: var(--bg-page);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 24px;
            position: relative;
        }
        
        .main-card {
            width: 100%;
            max-width: 480px;
            background: rgba(255, 255, 255, 0.15); /* Ultra transparente */
            padding: 48px;
            border-radius: 16px;
            box-shadow: var(--shadow-md);
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
        }
        
        .background-logo img {
            width: 350px;
            height: 350px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid rgba(0, 102, 204, 0.3);
            box-shadow: 0 8px 32px rgba(0, 102, 204, 0.4);
        }
        
        .background-logo .brand-name {
            font-size: 48px;
            font-weight: 800;
            color: var(--brand-primary);
            text-align: center;
            letter-spacing: -2px;
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 32px;
        }
        
        .logo-image {
            max-width: 120px;
            height: auto;
            margin-bottom: 16px;
            border-radius: 50%; /* Logo redondo */
            border: 3px solid var(--brand-primary);
            box-shadow: 0 4px 12px rgba(0, 102, 204, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .logo-image:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0, 102, 204, 0.3);
        }
        
        .brand-name {
            font-size: 28px;
            font-weight: 700;
            color: var(--brand-primary);
            margin-bottom: 8px;
            letter-spacing: -0.5px;
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
            color: #1a1a1a;
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

        .primary .label {
            color: var(--text-on-dark);
        }

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
           <!-- <span class="version-tag">v1.0</span> -->
            <h1>Gestión de Usuarios</h1>
            <p class="sub-description"><strong>Panel de control para administrar cuentas y accesos</strong></p>
        </div>
        
        <nav class="nav-stack">
            <a href="usuario?accion=listar" class="nav-link">
                <div class="label">Ver Todos los Usuarios</div>
                <span class="chevron">→</span>
            </a>
            
            <a href="crear.jsp" class="nav-link">
                <div class="label">Crear Nueva Cuenta</div>
                <span class="chevron">→</span>
            </a>
        </nav>
        
    </div>
    
    <!-- Logo de fondo grande -->
    <div class="background-logo">
        <img src="images/WhatsApp Image 2026-04-07 at 10.59.53 AM.jpeg" alt="E-form Logo" 
             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
        <div class="brand-name" style="display: none;">E-form</div>
    </div>
</body>
</html>