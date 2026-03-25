# Configuración para IDEs - Jakarta EE 10

## Configuración en Eclipse/IDE

### 1. Facetas del Proyecto
Selecciona las siguientes facetas:
- **Java**: 11
- **Dynamic Web Module**: 6.0
- **JavaScript**: 1.0

### 2. Configuración de Java EE
- **Java EE Version**: Jakarta EE 10 Web
- **Runtime**: Apache Tomcat v10.1 o superior

### 3. Dependencias Maven
El proyecto usa las siguientes versiones de Jakarta:
- Jakarta Servlet API: 6.0.0
- Jakarta JSP API: 3.1.1
- Jakarta JSTL: 3.0.1

### 4. Configuración del Servidor
Asegúrate de que Tomcat esté configurado con:
- **Tomcat Version**: 10.1+
- **JRE**: Java 11 o superior
- **Server Location**: Usar instalación de Tomcat

### 5. Problemas Comunes y Soluciones

#### Error: "No se encuentra la clase jakarta.servlet.*"
- **Solución**: Verifica que las facetas del proyecto estén configuradas para Jakarta EE 10
- **Revisa**: Que el runtime del servidor sea Tomcat 10+

#### Error: "javax.servlet.* not found"
- **Solución**: El proyecto usa Jakarta EE, no Java EE. Los imports deben ser `jakarta.*`

#### Error: "Web module version incompatible"
- **Solución**: Configura Dynamic Web Module a versión 6.0

### 6. Validación de Configuración

Para verificar que todo está configurado correctamente:

1. **Verifica imports**: Todos deben ser `jakarta.*`
2. **Verifica pom.xml**: Debe tener las dependencias correctas
3. **Verifica facetas**: Dynamic Web Module 6.0 y Jakarta EE 10
4. **Verifica servidor**: Tomcat 10+ con JRE 11+

### 7. Si aún tienes problemas

Si el IDE no te permite configurar Jakarta EE 10:

1. **Intenta con Jakarta EE 9** primero
2. **Luego actualiza a Jakarta EE 10**
3. **Reinicia el IDE** después de cambiar la configuración
4. **Limpia y reconstruye el proyecto**: `mvn clean install`
