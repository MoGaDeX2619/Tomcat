# Proyecto Usuarios Web App

Aplicación web completa en Java para gestión de usuarios utilizando Maven, Servlets, JSP y MySQL.

## 📋 Requisitos

- Java 11 o superior
- Apache Tomcat 10
- MySQL Server
- Maven 3.6+

## 🚀 Configuración

### 1. Base de Datos

Ejecuta el script `database_setup.sql` en tu servidor MySQL para crear la base de datos y tabla:

```bash
mysql -u root -p < database_setup.sql
```

O ejecuta manualmente:

```sql
CREATE DATABASE nelson_prueba;
USE nelson_prueba;

CREATE TABLE usuarios (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'USER'
);
```

### 2. Compilar el Proyecto

```bash
mvn clean compile
```

### 3. Generar WAR

```bash
mvn clean package
```

### 4. Desplegar en Tomcat

Copia el archivo `target/proyecto-usuarios.war` al directorio `webapps` de Tomcat.

## 📁 Estructura del Proyecto

```
src/
├── main/
│   ├── java/
│   │   └── com/mycompany/
│   │       ├── conexion/
│   │       │   └── ConexionDB.java
│   │       ├── modelo/
│   │       │   └── Usuario.java
│   │       ├── dao/
│   │       │   └── UsuarioDAO.java
│   │       └── servlet/
│   │           └── UsuarioServlet.java
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml
│       ├── index.jsp
│       ├── crear.jsp
│       ├── listar.jsp
│       └── editar.jsp
└── pom.xml
```

## 🔧 Configuración de Conexión

La conexión a MySQL está configurada en `ConexionDB.java`:

- **URL**: `jdbc:mysql://127.0.0.1:3306/nelson_prueba`
- **Usuario**: `root`
- **Contraseña**: `mogadex123`

Si necesitas cambiar estos valores, modifica la clase `ConexionDB.java`.

## 🌐 Acceso a la Aplicación

Una vez desplegado en Tomcat, accede a:

- **Inicio**: `http://localhost:8080/proyecto-usuarios/`
- **Listar Usuarios**: `http://localhost:8080/proyecto-usuarios/usuario?accion=listar`

## ✅ Funcionalidades

### CRUD Completo
- ✅ **Crear**: Formulario para nuevos usuarios con validaciones
- ✅ **Leer**: Listado de todos los usuarios
- ✅ **Actualizar**: Formulario de edición de usuarios
- ✅ **Eliminar**: Eliminación con confirmación

### Validaciones Implementadas
1. **Nombre**: No puede estar vacío
2. **Correo**: Debe contener @ y .
3. **Contraseña**: Mínimo 4 caracteres
4. **Rol**: Selección obligatoria

### Características
- 📱 Interfaz responsive y moderna
- 🔔 Mensajes de éxito y error
- 🛡️ Protección contra inyección SQL (PreparedStatement)
- 🎨 Diseño limpio y profesional
- ⚡ Compatible con Apache Tomcat 10

## 🎯 Roles Disponibles

- **ADMIN**: Administrador del sistema
- **USER**: Usuario regular
- **MODERATOR**: Moderador

## 🔒 Notas de Seguridad

- ✅ **Las contraseñas se almacenan con hash MD5** para mayor seguridad
- ✅ **Protección contra inyección SQL** mediante PreparedStatement
- ⚠️ **Nota importante**: MD5 es básico para demostración. En producción considera:
  - **Algoritmos más seguros**: BCrypt, PBKDF2, Argon2
  - **Salt**: Añadir salt único por contraseña
  - **HTTPS**: Siempre usar conexión segura

### Ejemplo de contraseñas hasheadas:
- `admin123` → `0192023a7bbd73250516f069df18b500`
- `user123` → `482c811da5d5b4bc6d497ffa98491e38`
- `mod123` → `5d9c68c6c50ed3d02a2fcf54f1e80dbd`

## 🐛 Solución de Problemas

### Problemas Comunes

1. **Error de conexión MySQL**
   - Verifica que MySQL esté corriendo
   - Confirma usuario/contraseña en `ConexionDB.java`
   - Asegúrate que la base de datos `nelson_prueba` exista

2. **Error 404 en Tomcat**
   - Verifica que el WAR se desplegó correctamente
   - Confirma el nombre del contexto (`proyecto-usuarios`)

3. **Error de compilación**
   - Asegúrate de tener Java 11+
   - Verifica las dependencias Maven

## 📝 Licencia

Proyecto educativo para demostrar el uso de Java Web Technologies.
