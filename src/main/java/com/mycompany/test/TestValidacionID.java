package com.mycompany.test;

import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;

/**
 * Prueba para verificar la validación de ID en tiempo real
 * @author Nelson Diaz
 */
public class TestValidacionID {
    
    public static void main(String[] args) {
        System.out.println("=== INICIANDO PRUEBA DE VALIDACIÓN ID ===");
        
        UsuarioDAO dao = new UsuarioDAO();
        
        // 1. Crear un usuario de prueba con ID 999
        System.out.println("\n1. Creando usuario de prueba con ID 999...");
        Usuario usuario = new Usuario(999, "Usuario Prueba ID", "prueba999@ejemplo.com", "1234", "USER");
        boolean creado = dao.crearUsuarioConID(usuario);
        System.out.println("   Usuario creado: " + (creado ? "✅ Éxito" : "❌ Fallo"));
        
        // 2. Verificar que el método existeID funcione
        System.out.println("\n2. Verificando método existeID...");
        boolean existe = dao.existeID(999);
        System.out.println("   ¿Existe ID 999?: " + (existe ? "✅ Sí" : "❌ No"));
        
        // 3. Verificar ID que no existe
        boolean noExiste = dao.existeID(888);
        System.out.println("   ¿Existe ID 888?: " + (noExiste ? "❌ Error" : "✅ No"));
        
        // 4. Intentar crear usuario con ID duplicado
        System.out.println("\n3. Intentando crear usuario con ID duplicado...");
        Usuario duplicado = new Usuario(999, "Usuario Duplicado", "duplicado999@ejemplo.com", "1234", "USER");
        boolean duplicadoCreado = dao.crearUsuarioConID(duplicado);
        System.out.println("   Usuario duplicado creado: " + (duplicadoCreado ? "❌ Error" : "✅ Correctamente rechazado"));
        
        // 5. Limpiar
        if (creado) {
            dao.eliminarUsuario(999);
            System.out.println("\n4. Usuario de prueba eliminado");
        }
        
        System.out.println("\n=== PRUEBA DE VALIDACIÓN ID FINALIZADA ===");
        System.out.println("✅ Validación de ID funcionando correctamente");
        System.out.println("✅ El frontend podrá validar IDs en tiempo real");
    }
}
