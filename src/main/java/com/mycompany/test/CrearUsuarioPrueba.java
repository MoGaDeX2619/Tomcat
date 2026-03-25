package com.mycompany.test;

import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;

/**
 * Crear usuario de prueba para validar ID
 */
public class CrearUsuarioPrueba {
    
    public static void main(String[] args) {
        System.out.println("=== CREANDO USUARIO DE PRUEBA ===");
        
        UsuarioDAO dao = new UsuarioDAO();
        
        // Crear usuario con ID 123 para prueba
        Usuario usuario = new Usuario(123, "Usuario Prueba", "prueba123@ejemplo.com", "Password123!", "USER");
        
        boolean creado = dao.crearUsuarioConID(usuario);
        System.out.println("Usuario con ID 123 creado: " + (creado ? "✅ Éxito" : "❌ Fallo"));
        
        if (creado) {
            System.out.println("Ahora puedes probar la validación con ID 123 (debería decir que existe)");
            System.out.println("Y con cualquier otro ID (debería decir que está disponible)");
        }
        
        System.out.println("=== USUARIO DE PRUEBA CREADO ===");
    }
}
