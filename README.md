# EA04 - Módulo Web CRUD

## Descripción

Este proyecto implementa un módulo web completo para la gestión de usuarios utilizando tecnología Java EE con servlets y JSP. Cumple con los requisitos de la actividad EA04 del proceso formativo, demostrando el manejo de operaciones CRUD, validaciones y persistencia de datos.

## Características Implementadas

### ✅ Requisitos Obligatorios EA04
- **2 Formularios Mínimo**: Formulario de creación y formulario de edición/búsqueda
- **Manejo de GET/POST**: Gestión adecuada de métodos HTTP
- **3+ Validaciones Básicas**: 
  - Validación de nombre (3-50 caracteres)
  - Validación de apellido (3-50 caracteres)  
  - Validación de email (formato válido + unicidad)
  - Validación de teléfono (solo números, 8-15 dígitos)
  - Validación de dirección (5-200 caracteres)
- **Evidencia de Funcionamiento**: Capturas de pantalla y documentación
- **Persistencia de Datos**: Base de datos MySQL con conexión JDBC

### ✅ Plus Recomendado
- **Manejo de Mensajes**: Sistema completo de notificaciones éxito/error en UI
- **Interfaz Moderna**: Bootstrap 5 + Font Awesome
- **Validación en Cliente y Servidor**: Doble validación para mejor experiencia
- **Búsqueda Integrada**: Búsqueda por nombre y apellido
- **Diseño Responsivo**: Adaptable a diferentes dispositivos

## Tecnologías Utilizadas

- **Backend**: Java EE (Servlets + JSP)
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5, Font Awesome
- **Base de Datos**: MySQL 8.0
- **Conexión**: JDBC
- **Construcción**: Maven
- **Servidor**: Apache Tomcat 9+

## Estructura del Proyecto

```
tarea_EA4/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/ea4/
│       │       ├── dao/
│       │       │   └── UsuarioDAO.java
│       │       ├── model/
│       │       │   └── Usuario.java
│       │       ├── servlet/
│       │       │   └── UsuarioServlet.java
│       │       └── util/
│       │           └── DatabaseConnection.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── crear-usuario.jsp
│           ├── editar-usuario.jsp
│           ├── index.jsp
│           └── error404.jsp
├── database.sql
├── pom.xml
└── README.md
```

## Configuración y Ejecución

### 1. Configuración de Base de Datos
```sql
-- Crear base de datos
CREATE DATABASE ea4_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Importar el esquema
mysql -u root -p ea4_db < database.sql
```

### 2. Configuración del Proyecto
1. **Requisitos previos**:
   - JDK 11 o superior
   - Apache Maven 3.6+
   - Apache Tomcat 9+
   - MySQL Server 8.0+

2. **Compilar el proyecto**:
   ```bash
   mvn clean compile
   ```

3. **Generar WAR**:
   ```bash
   mvn clean package
   ```

4. **Desplegar en Tomcat**:
   - Copiar `target/modulo-web-crud.war` al directorio `webapps` de Tomcat
   - Iniciar Tomcat
   - Acceder a: `http://localhost:8080/modulo-web-crud/`

### 3. Ejecutar con Maven Tomcat Plugin
```bash
mvn tomcat7:run
```
Luego acceder a: `http://localhost:8080/modulo-web-crud/`

## Funcionalidades Detalladas

### 1. Creación de Usuarios
- **URL**: `/crear-usuario.jsp`
- **Método**: POST
- **Validaciones**: Nombre, apellido, email, teléfono, dirección
- **Características**: Validación en tiempo real, mensajes de error específicos

### 2. Listado y Búsqueda de Usuarios
- **URL**: `/usuarios`
- **Método**: GET
- **Características**: 
  - Listado completo de usuarios
  - Búsqueda por nombre/apellido
  - Paginación preparada
  - Ordenamiento por fecha de creación

### 3. Edición de Usuarios
- **URL**: `/usuarios?accion=editar&id={id}`
- **Método**: GET/POST
- **Características**: 
  - Carga de datos existentes
  - Validación de unicidad de email
  - Mantenimiento de timestamps

### 4. Eliminación de Usuarios
- **URL**: `/usuarios?accion=eliminar&id={id}`
- **Método**: GET
- **Características**: Confirmación JavaScript, eliminación en cascada

## Validaciones Implementadas

### Validaciones en Servidor
1. **Nombre**: Obligatorio, 3-50 caracteres
2. **Apellido**: Obligatorio, 3-50 caracteres
3. **Email**: Obligatorio, formato válido, único
4. **Teléfono**: Obligatorio, solo números, 8-15 dígitos
5. **Dirección**: Obligatorio, 5-200 caracteres

### Validaciones en Cliente
- Validación en tiempo real con JavaScript
- Expresiones regulares para email y teléfono
- Retroalimentación visual inmediata
- Prevenir envío de formulario con errores

## Evidencias de Aprendizaje

### Capturas de Pantalla (Incluidas en documentación)
1. **Página Principal**: Vista general del sistema
2. **Formulario de Creación**: Formulario con validaciones
3. **Listado de Usuarios**: Tabla con datos de la BD
4. **Formulario de Edición**: Modificación de datos
5. **Mensajes de Éxito/Error**: Sistema de notificaciones
6. **Base de Datos**: Evidencia de persistencia

### Commits en Repositorio
- Estructura inicial del proyecto
- Implementación del modelo de datos
- Creación del DAO y conexión a BD
- Desarrollo de servlets y lógica de negocio
- Implementación de validaciones
- Diseño de interfaz de usuario
- Integración y testing final

## Estándares de Codificación

### Convenciones Seguidas
- **Nomenclatura**: Java naming conventions
- **Comentarios**: Javadoc para clases y métodos públicos
- **Estructura**: Patrón MVC con separación de responsabilidades
- **Seguridad**: PreparedStatement contra SQL Injection
- **Manejo de Errores**: Try-catch con logging apropiado
- **Codificación**: UTF-8 en toda la aplicación

### Buenas Prácticas
- Inyección de dependencias preparada
- Código reutilizable y mantenible
- Validaciones en múltiples capas
- URLs RESTful semánticas
- Diseño responsive y accesible

## Problemas Conocidos y Soluciones

### 1. Codificación de Caracteres
- **Problema**: Caracteres especiales en español
- **Solución**: Filtro UTF-8 en web.xml y meta tags HTML

### 2. Conexión a Base de Datos
- **Problema**: Timezone de MySQL
- **Solución**: Configuración UTC en conexión JDBC

### 3. Validaciones Doble
- **Problema**: Redundancia de validaciones
- **Solución**: Separación clara cliente/servidor

## Extensiones Futuras

1. **Autenticación y Autorización**: Sistema de login y roles
2. **API REST**: Endpoints para consumo externo
3. **Testing Unitario**: JUnit para validaciones
4. **Logging**: Implementación con Log4j2
5. **Cache**: Redis para mejorar rendimiento
6. **Docker**: Contenerización completa

## Licencia

Este proyecto fue desarrollado como evidencia de aprendizaje para el proceso formativo EA04.

## Contacto

Para consultas técnicas sobre este proyecto, referirse a la documentación del curso o al instructor asignado.
