package com.mycompany.test;

import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Clase de prueba para verificar la validación de ID y correo duplicados
 * @author Nelson Diaz
 */
public class TestValidacion {
    
    public static void main(String[] args) {
        System.out.println("=== INICIANDO PRUEBAS DE VALIDACIÓN ===");
        
        UsuarioDAO dao = new UsuarioDAO();
        
        // 1. Probar crear usuario con ID existente
        probarIDExistente(dao);
        
        // 2. Probar crear usuario con correo existente
        probarCorreoExistente(dao);
        
        // 3. Probar crear usuario con ID nuevo
        probarIDNuevo(dao);
        
        System.out.println("=== PRUEBAS DE VALIDACIÓN FINALIZADAS ===");
    }
    
    private static void probarIDExistente(UsuarioDAO dao) {
        System.out.println("\n1. Probando creación con ID existente...");
        
        // Primero creamos un usuario con ID 100
        Usuario usuario1 = new Usuario(100, "Usuario Test ID", "testid@ejemplo.com", "1234", "USER");
        boolean creado1 = dao.crearUsuarioConID(usuario1);
        System.out.println("   Usuario con ID 100 creado: " + (creado1 ? "✅ Éxito" : "❌ Fallo"));
        
        // Intentamos crear otro usuario con el mismo ID 100
        Usuario usuario2 = new Usuario(100, "Usuario Duplicado", "duplicado@ejemplo.com", "1234", "USER");
        boolean creado2 = dao.crearUsuarioConID(usuario2);
        System.out.println("   Usuario duplicado con ID 100 creado: " + (creado2 ? "❌ Error" : "✅ Correctamente rechazado"));
        
        // Limpiar
        if (creado1) {
            dao.eliminarUsuario(100);
            System.out.println("   Usuario ID 100 eliminado para limpieza");
        }
    }
    
    private static void probarCorreoExistente(UsuarioDAO dao) {
        System.out.println("\n2. Probando creación con correo existente...");
        
        // Primero creamos un usuario
        Usuario usuario1 = new Usuario(200, "Usuario Test Correo", "testcorreo@ejemplo.com", "1234", "USER");
        boolean creado1 = dao.crearUsuarioConID(usuario1);
        System.out.println("   Usuario con correo testcorreo@ejemplo.com creado: " + (creado1 ? "✅ Éxito" : "❌ Fallo"));
        
        // Intentamos crear otro usuario con el mismo correo
        Usuario usuario2 = new Usuario(201, "Usuario Correo Duplicado", "testcorreo@ejemplo.com", "1234", "USER");
        boolean creado2 = dao.crearUsuarioConID(usuario2);
        System.out.println("   Usuario con correo duplicado creado: " + (creado2 ? "❌ Error" : "✅ Correctamente rechazado"));
        
        // Limpiar
        if (creado1) {
            dao.eliminarUsuario(200);
            System.out.println("   Usuario con correo testcorreo@ejemplo.com eliminado para limpieza");
        }
    }
    
    private static void probarIDNuevo(UsuarioDAO dao) {
        System.out.println("\n3. Probando creación con ID nuevo...");
        
        // Creamos un usuario con ID que no debería existir
        String timestamp = String.valueOf(System.currentTimeMillis());
        int idUnico = Integer.parseInt(timestamp.substring(timestamp.length() - 6)); // Últimos 6 dígitos
        
        Usuario usuario = new Usuario(idUnico, "Usuario ID Único", "unico" + idUnico + "@ejemplo.com", "1234", "USER");
        boolean creado = dao.crearUsuarioConID(usuario);
        System.out.println("   Usuario con ID único " + idUnico + " creado: " + (creado ? "✅ Éxito" : "❌ Fallo"));
        
        // Verificar que el ID existe
        boolean existe = dao.existeID(idUnico);
        System.out.println("   Verificación de ID " + idUnico + " existe: " + (existe ? "✅ Confirmado" : "❌ No encontrado"));
        
        // Limpiar
        if (creado) {
            dao.eliminarUsuario(idUnico);
            System.out.println("   Usuario ID único eliminado para limpieza");
        }
    }
}
