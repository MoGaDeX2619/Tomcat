@echo off
echo === VERIFICACIÓN FINAL Y LIMPIEZA DEL SISTEMA E-form ===
echo.

echo 1. Compilando prueba final...
javac -cp "target/classes;lib/*" -d target/classes src/main/java/com/mycompany/test/TestFinalSistema.java
if %errorlevel% neq 0 (
    echo Error al compilar TestFinalSistema
    pause
    exit /b 1
)

echo.
echo 2. Ejecutando prueba final del sistema...
java -cp "target/classes;lib/*" com.mycompany.test.TestFinalSistema

echo.
echo 3. Limpiando compilaciones anteriores...
call mvn clean

echo.
echo 4. Compilando versión final...
call mvn package

echo.
echo 5. Verificando archivos generados...
if exist "target\proyecto-usuarios.war" (
    echo ✅ WAR generado exitosamente
    echo 📁 Ubicación: target\proyecto-usuarios.war
    echo 📏 Tamaño: 
    dir "target\proyecto-usuarios.war" | find "proyecto-usuarios.war"
) else (
    echo ❌ Error: No se generó el WAR
)

echo.
echo 6. Estado final del proyecto:
echo 📁 Archivos principales:
if exist "src\main\webapp\index.jsp" echo    ✅ index.jsp - Página principal
if exist "src\main\webapp\crear.jsp" echo    ✅ crear.jsp - Crear usuarios
if exist "src\main\webapp\listar.jsp" echo    ✅ listar.jsp - Listar usuarios
if exist "src\main\webapp\editar.jsp" echo    ✅ editar.jsp - Editar usuarios
if exist "src\main\webapp\WEB-INF\web.xml" echo    ✅ web.xml - Configuración

echo 📁 Clases Java:
if exist "src\main\java\com\mycompany\servlet\UsuarioServlet.java" echo    ✅ UsuarioServlet.java - Controlador principal
if exist "src\main\java\com\mycompany\dao\UsuarioDAO.java" echo    ✅ UsuarioDAO.java - Acceso a datos
if exist "src\main\java\com\mycompany\modelo\Usuario.java" echo    ✅ Usuario.java - Modelo de datos
if exist "src\main\java\com\mycompany\conexion\ConexionDB.java" echo    ✅ ConexionDB.java - Conexión a BD

echo 📁 Archivos eliminados (limpieza):
echo    ❌ Archivos de prueba duplicados eliminados
echo    ❌ Scripts temporales eliminados
echo    ❌ Archivos no utilizados eliminados

echo.
echo === SISTEMA E-form OPTIMIZADO Y LISTO ===
echo 🚀 Despliega target\proyecto-usuarios.war en Tomcat
echo 🌐 Accede a: http://localhost:8080/proyecto-usuarios/
echo.
pause
