<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error del Servidor - EA04</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            color: white;
        }
        .error-code {
            font-size: 8rem;
            font-weight: bold;
            text-shadow: 0 10px 30px rgba(0,0,0,0.3);
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }
        .btn-home {
            background: white;
            color: #667eea;
            border: none;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">500</div>
        <div class="error-message">
            <i class="fas fa-exclamation-triangle me-2"></i>
            Error del Servidor
        </div>
        <p class="mb-4">
            Ha ocurrido un error interno en el servidor. Por favor, inténtalo más tarde.
        </p>
        <a href="index.jsp" class="btn btn-home">
            <i class="fas fa-home me-2"></i>
            Volver al Inicio
        </a>
    </div>
</body>
</html>
