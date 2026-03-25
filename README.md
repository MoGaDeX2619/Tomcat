# Sistema de Gestión de Usuarios

Aplicación web completa en Java para gestión de usuarios utilizando Maven, Servlets, JSP y MySQL.

## 📋 Requisitos

- Java 11 o superior
- Apache Tomcat 10
- MySQL Server
- Maven 3.6+ (opcional)

## 🚀 Configuración Rápida

### 1. Base de Datos

**Opción A: Ejecutar script automático**
```bash
java -cp "target/classes;lib/*" com.mycompany.test.FixDatabase
```

**Opción B: Manual**
```bash
mysql -u root -p < database_setup.sql
```

### 2. Compilar el Proyecto

```bash
# Opción A: Sin Maven
javac -cp "target/classes;lib/*" -d target/classes src/main/java/com/mycompany/*/*.java

# Opción B: Con Maven
mvn clean compile
```

### 3. Desplegar en Tomcat

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
│   │       ├── servlet/
│   │       │   └── UsuarioServlet.java
│   │       └── test/
│   │           ├── TestConexion.java
│   │           └── FixDatabase.java
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml
│       ├── index.jsp
│       ├── crear.jsp
│       ├── listar.jsp
│       └── editar.jsp
├── lib/
│   └── mysql-connector-j-8.3.0.jar
├── database_setup.sql
├── fix_database.bat
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
- 🔔 Mensajes de éxito y error detallados
- 🛡️ Protección contra inyección SQL (PreparedStatement)
- 🎨 Diseño limpio y profesional
- ⚡ Compatible con Apache Tomcat 10
- 📊 Logs detallados para depuración
- 🆔 **Validación de ID único**: Previene duplicados de ID
- ✉️ **Validación de correo único**: Evita correos duplicados
- 🔒 **Control de integridad**: Solo permite IDs disponibles
- ⚡ **Validación en tiempo real**: Verifica ID mientras escribes
- 🔐 **Seguridad de contraseñas**: No se almacenan en el formulario
- 🎯 **Feedback visual inmediato**: Colores rojo/verde para validación

## 🧪 Pruebas

### Ejecutar Pruebas Completas

```bash
java -cp "target/classes;lib/*" com.mycompany.test.TestConexion
```

Esta prueba verifica:
- ✅ Conexión a la base de datos
- ✅ Operaciones CRUD (Crear, Leer, Actualizar, Eliminar)
- ✅ Manejo de errores
- ✅ Logs detallados

**Nota**: La prueba crea y elimina un usuario automáticamente para verificar el funcionamiento.

### Ejecutar Pruebas de Validación

```bash
java -cp "target/classes;lib/*" com.mycompany.test.TestValidacion
```

Esta prueba verifica:
- ✅ **Validación de ID duplicado**: Rechaza crear usuarios con ID existente
- ✅ **Validación de correo duplicado**: Rechaza crear usuarios con correo existente
- ✅ **Creación con ID único**: Permite crear usuarios con ID nuevos
- ✅ **Integridad de datos**: Mantiene la consistencia de la base de datos

### Ejecutar Pruebas de Validación de ID

```bash
java -cp "target/classes;lib/*" com.mycompany.test.TestValidacionID
```

Esta prueba verifica:
- ✅ **Método existeID()**: Funcionamiento correcto de verificación
- ✅ **Validación en tiempo real**: Preparación para validación AJAX
- ✅ **Rechazo de duplicados**: IDs duplicados correctamente rechazados
- ✅ **Aceptación de únicos**: IDs nuevos correctamente aceptados

## 👥 Usuarios

La base de datos inicia vacía. Los usuarios se crean únicamente a través de la interfaz web.

### Roles Disponibles

- **ADMIN**: Administrador del sistema
- **USER**: Usuario regular
- **MODERATOR**: Moderador

## 🔒 Notas de Seguridad

- ✅ **Las contraseñas se almacenan con hash MD5** para mayor seguridad
- ✅ **Protección contra inyección SQL** mediante PreparedStatement
- ✅ **Validación de entrada en el servidor**
- ✅ **Configuración de codificación UTF-8**
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

1. **Driver MySQL no encontrado**
   ```bash
   # Asegurarse que el driver esté en lib/
   # Descargar si es necesario:
   powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar' -OutFile 'lib/mysql-connector-j-8.3.0.jar'"
   ```

2. **Error de conexión MySQL**
   - Verifica que MySQL esté corriendo
   - Confirma usuario/contraseña en `ConexionDB.java`
   - Ejecuta: `java -cp "target/classes;lib/*" com.mycompany.test.FixDatabase`

3. **Error AUTO_INCREMENT**
   - La tabla necesita ser recreada correctamente
   - Ejecuta: `java -cp "target/classes;lib/*" com.mycompany.test.FixDatabase`

4. **Error 404 en Tomcat**
   - Verifica que el WAR se desplegó correctamente
   - Confirma el nombre del contexto (`proyecto-usuarios`)

5. **Error de compilación**
   - Asegúrate de tener Java 11+
   - Verifica las dependencias en `lib/`

### Logs y Depuración

La aplicación incluye mensajes de consola detallados:
- Conexiones a base de datos
- Operaciones CRUD con resultados
- Errores SQL con códigos de estado
- Traza completa de excepciones

## 📝 Licencia

Proyecto educativo para demostrar el uso de Java Web Technologies.

**Autor**: Nelson Diaz
