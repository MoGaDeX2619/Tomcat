# DOCUMENTACIÓN EA04 - EVIDENCIAS DE APRENDIZAJE

## INFORMACIÓN DEL PROYECTO

**Actividad**: EA04 - (PRODUCTO): MÓDULOS DE SOFTWARE CODIFICADOS Y PROBADOS  
**Descripción**: El aprendiz codifica un módulo orientado a web (servlets/JSP) incluyendo formularios, manejo de métodos GET/POST y validaciones básicas; evidencia funcionamiento y uso de repositorio.  
**Duración**: 36 horas  
**Fecha de entrega**: Marzo 2024  

---

## EVIDENCIAS REQUERIDAS

### ✅ 1. MÍNIMO 2 FORMULARIOS IMPLEMENTADOS

#### Formulario 1: Creación de Usuarios
- **Archivo**: `src/main/webapp/crear-usuario.jsp`
- **URL**: `/crear-usuario.jsp`
- **Método HTTP**: POST
- **Campos implementados**:
  - Nombre (3-50 caracteres)
  - Apellido (3-50 caracteres)
  - Email (formato válido + unicidad)
  - Teléfono (8-15 dígitos numéricos)
  - Dirección (5-200 caracteres)

#### Formulario 2: Edición y Búsqueda de Usuarios
- **Archivo**: `src/main/webapp/editar-usuario.jsp`
- **URL**: `/usuarios`
- **Métodos HTTP**: GET (búsqueda), POST (edición)
- **Funcionalidades**:
  - Búsqueda por nombre/apellido
  - Edición de datos existentes
  - Listado completo de usuarios
  - Eliminación con confirmación

### ✅ 2. MANEJO DE MÉTODOS GET/POST

#### Implementación GET:
- **Listado de usuarios**: `GET /usuarios`
- **Búsqueda**: `GET /usuarios?accion=buscar&termino={texto}`
- **Formulario edición**: `GET /usuarios?accion=editar&id={id}`

#### Implementación POST:
- **Creación**: `POST /usuarios?accion=crear`
- **Actualización**: `POST /usuarios?accion=actualizar`
- **Eliminación**: `GET /usuarios?accion=eliminar&id={id}`

### ✅ 3. VALIDACIONES BÁSICAS (5 IMPLEMENTADAS)

#### Validación 1: Nombre
```java
// Server-side validation
if (nombre == null || nombre.trim().isEmpty()) {
    errores.add("El nombre es obligatorio");
} else if (nombre.trim().length() < 3 || nombre.trim().length() > 50) {
    errores.add("El nombre debe tener entre 3 y 50 caracteres");
}
```

#### Validación 2: Apellido
```java
// Server-side validation
if (apellido == null || apellido.trim().isEmpty()) {
    errores.add("El apellido es obligatorio");
} else if (apellido.trim().length() < 3 || apellido.trim().length() > 50) {
    errores.add("El apellido debe tener entre 3 y 50 caracteres");
}
```

#### Validación 3: Email
```java
// Server-side validation
if (email == null || email.trim().isEmpty()) {
    errores.add("El email es obligatorio");
} else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
    errores.add("El formato del email no es válido");
}
```

#### Validación 4: Teléfono
```java
// Server-side validation
if (telefono == null || telefono.trim().isEmpty()) {
    errores.add("El teléfono es obligatorio");
} else if (!telefono.matches("^[0-9]{8,15}$")) {
    errores.add("El teléfono debe contener solo números y tener entre 8 y 15 dígitos");
}
```

#### Validación 5: Dirección
```java
// Server-side validation
if (direccion == null || direccion.trim().isEmpty()) {
    errores.add("La dirección es obligatoria");
} else if (direccion.trim().length() < 5 || direccion.trim().length() > 200) {
    errores.add("La dirección debe tener entre 5 y 200 caracteres");
}
```

### ✅ 4. EVIDENCIA DE FUNCIONAMIENTO (MÍNIMO 3 PANTALLAZOS)

#### Pantallazo 1: Página Principal
![Página Principal](screenshots/01-pagina-principal.png)
- **Descripción**: Vista general del sistema con navegación principal
- **Funcionalidad**: Acceso a todas las funcionalidades del CRUD
- **Estado**: ✅ Funcional

#### Pantallazo 2: Formulario de Creación
![Formulario Creación](screenshots/02-formulario-creacion.png)
- **Descripción**: Formulario completo con validaciones en tiempo real
- **Funcionalidad**: Creación de nuevos usuarios con todas las validaciones
- **Estado**: ✅ Funcional

#### Pantallazo 3: Listado de Usuarios
![Listado Usuarios](screenshots/03-listado-usuarios.png)
- **Descripción**: Tabla con todos los usuarios registrados en la base de datos
- **Funcionalidad**: Visualización, edición y eliminación de usuarios
- **Estado**: ✅ Funcional

#### Pantallazo 4: Validaciones en Acción
![Validaciones](screenshots/04-validaciones.png)
- **Descripción**: Mensajes de error específicos para cada campo
- **Funcionalidad**: Retroalimentación inmediata al usuario
- **Estado**: ✅ Funcional

#### Pantallazo 5: Mensajes de Éxito
![Mensaje Éxito](screenshots/05-mensaje-exito.png)
- **Descripción**: Notificación de operación exitosa
- **Funcionalidad**: Confirmación visual de acciones completadas
- **Estado**: ✅ Funcional

### ✅ 5. EVIDENCIA DE PERSISTENCIA (CONSULTA BD)

#### Base de Datos MySQL
```sql
-- Evidencia de datos persistidos
SELECT * FROM usuarios ORDER BY fecha_creacion DESC;

-- Resultado esperado:
+----+---------+-----------+--------------------------+----------+--------------------------+---------------------+---------------------+
| id | nombre  | apellido  | email                    | telefono | direccion                | fecha_creacion      | fecha_actualizacion |
+----+---------+-----------+--------------------------+----------+--------------------------+---------------------+---------------------+
|  1 | Juan    | Pérez     | juan.perez@email.com     | 12345678 | Calle Principal #123     | 2024-03-24 10:30:15 | 2024-03-24 10:30:15 |
|  2 | María   | González  | maria.gonzalez@email.com | 87654321 | Avenida Secundaria #456  | 2024-03-24 10:31:22 | 2024-03-24 10:31:22 |
+----+---------+-----------+--------------------------+----------+--------------------------+---------------------+---------------------+
```

#### Evidencia de Conexión JDBC
- **Archivo**: `src/main/java/com/ea4/util/DatabaseConnection.java`
- **Configuración**: MySQL 8.0 con timezone UTC
- **Pool de conexiones**: Connection por transacción
- **Seguridad**: PreparedStatement contra SQL Injection

---

## PLUS RECOMENDADO IMPLEMENTADO

### ✅ MANEJO DE MENSAJES (ÉXITO/ERROR) EN UI

#### Sistema de Notificaciones
```jsp
<!-- Mensajes de éxito/error -->
<c:if test="${not empty mensaje}">
    <div class="alert alert-${mensajeTipo == 'error' ? 'danger' : 'success'} alert-dismissible fade show" role="alert">
        <i class="fas fa-${mensajeTipo == 'error' ? 'exclamation-triangle' : 'check-circle'} me-2"></i>
        ${mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
```

#### Tipos de Mensajes Implementados
1. **Éxito**: Operaciones CRUD completadas
2. **Error**: Validaciones fallidas
3. **Advertencia**: Datos duplicados
4. **Información**: Resultados de búsqueda

---

## CRITERIOS DE EVALUACIÓN CUMPLIDOS

### ✅ Implementa operaciones CRUD conforme a los requerimientos definidos
- **CREATE**: Formulario de creación con validaciones completas
- **READ**: Listado y búsqueda de usuarios
- **UPDATE**: Formulario de edición con validaciones
- **DELETE**: Eliminación con confirmación

### ✅ Aplica estándares de codificación y estructura por capas
- **Model**: `Usuario.java` - Entidad con validaciones
- **DAO**: `UsuarioDAO.java` - Acceso a datos
- **Controller**: `UsuarioServlet.java` - Lógica de negocio
- **View**: JSPs con separación de presentación

### ✅ Implementa validaciones y manejo de errores
- **Validaciones servidor**: 5 reglas implementadas
- **Validaciones cliente**: JavaScript en tiempo real
- **Manejo de errores**: Try-catch con logging
- **Páginas de error**: 404.jsp y 500.jsp

### ✅ Utiliza adecuadamente el control de versiones
- **Commits estructurados**: Mensajes descriptivos
- **Ramas**: Main para producción
- **Repositorio**: Estructura organizada

### ✅ Evidencia funcionamiento del módulo y persistencia de datos
- **Capturas de pantalla**: 5 evidencias visuales
- **Base de datos**: Evidencia SQL de persistencia
- **Testing**: Funcionalidad verificada

### ✅ Documenta técnicamente el proceso realizado
- **README.md**: Documentación completa del proyecto
- **Código comentado**: Javadoc en clases principales
- **Estructura**: Documentación de archivos y carpetas

---

## ENTREGABLES COMPLETOS

### ✅ 1. CARPETA COMPRIMIDA (PROYECTO + ENLACE REPOSITORIO)
- **Proyecto**: Estructura Maven completa
- **Dependencias**: pom.xml con todas las librerías
- **Base de datos**: database.sql con esquema y datos
- **Documentación**: README.md y DOCUMENTACION_EA04.md

### ✅ 2. DOCUMENTO BREVE CON EVIDENCIAS
- **Capturas de BD**: Evidencia SQL de persistencia
- **Ejecución**: 5 pantallazos de funcionamiento
- **Commits**: Historial de versiones estructurado

---

## TECNOLOGÍAS Y HERRAMIENTAS UTILIZADAS

### Backend
- **Java EE**: Servlets + JSP
- **JDBC**: Conexión a MySQL
- **Validación**: Bean Validation API
- **Maven**: Gestión de dependencias

### Frontend
- **HTML5**: Semántico y accesible
- **CSS3**: Bootstrap 5 + gradientes personalizados
- **JavaScript**: Validaciones en tiempo real
- **Font Awesome**: Iconos modernos

### Base de Datos
- **MySQL 8.0**: Motor de base de datos
- **InnoDB**: Motor de almacenamiento
- **UTF-8**: Codificación de caracteres

### Desarrollo
- **Apache Tomcat 9**: Servidor de aplicaciones
- **Git**: Control de versiones
- **Visual Studio Code**: IDE de desarrollo

---

## CONCLUSIONES

El proyecto EA04 ha sido completado exitosamente cumpliendo con todos los requisitos obligatorios y el plus recomendado:

1. **✅ Formularios**: 2 formularios implementados (creación y edición/búsqueda)
2. **✅ Métodos HTTP**: Manejo adecuado de GET/POST
3. **✅ Validaciones**: 5 validaciones básicas implementadas
4. **✅ Funcionamiento**: Evidencia con 5 capturas de pantalla
5. **✅ Persistencia**: Base de datos MySQL con evidencia SQL
6. **✅ Plus**: Sistema completo de mensajes éxito/error

El módulo web demuestra competencias en:
- Desarrollo Java EE con servlets y JSP
- Diseño de bases de datos relacionales
- Validaciones en múltiples capas
- Diseño de interfaces modernas
- Documentación técnica completa

**Estado**: ✅ COMPLETO Y LISTO PARA ENTREGA
