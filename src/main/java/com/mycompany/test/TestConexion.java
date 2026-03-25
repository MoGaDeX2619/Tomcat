package com.mycompany.test;

import com.mycompany.conexion.ConexionDB;
import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Clase de prueba para verificar la conexión y operaciones CRUD
 * @author Nelson Diaz
 */
public class TestConexion {
    
    public static void main(String[] args) {
        System.out.println("=== INICIANDO PRUEBAS DE CONEXIÓN Y CRUD ===");
        
        // 1. Probar conexión a la base de datos
        probarConexion();
        
        // 2. Probar operaciones CRUD
        probarCRUD();
        
        System.out.println("=== PRUEBAS FINALIZADAS ===");
    }
    
    private static void probarConexion() {
        System.out.println("\n1. Probando conexión a la base de datos...");
        
        try {
            Connection conn = ConexionDB.getConexion();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Conexión exitosa a la base de datos");
                System.out.println("   Base de datos: " + conn.getCatalog());
                System.out.println("   URL: " + conn.getMetaData().getURL());
                ConexionDB.cerrarConexion(conn);
            } else {
                System.out.println("❌ La conexión es nula o está cerrada");
            }
        } catch (SQLException e) {
            System.out.println("❌ Error de conexión: " + e.getMessage());
            System.out.println("   SQL State: " + e.getSQLState());
            System.out.println("   Error Code: " + e.getErrorCode());
        }
    }
    
    private static void probarCRUD() {
        System.out.println("\n2. Probando operaciones CRUD...");
        
        UsuarioDAO dao = new UsuarioDAO();
        
        // 2.1 Listar usuarios existentes
        System.out.println("\n2.1 Listando usuarios existentes:");
        List<Usuario> usuarios = dao.listarUsuarios();
        System.out.println("   Total usuarios encontrados: " + usuarios.size());
        for (Usuario u : usuarios) {
            System.out.println("   - ID: " + u.getIdUsuario() + 
                             ", Nombre: " + u.getNombre() + 
                             ", Correo: " + u.getCorreo() + 
                             ", Rol: " + u.getRol());
        }
        
        // 2.2 Crear un usuario de prueba
        System.out.println("\n2.2 Creando usuario de prueba:");
        String timestamp = String.valueOf(System.currentTimeMillis());
        Usuario nuevoUsuario = new Usuario(
            "Usuario Prueba " + timestamp,
            "test" + timestamp + "@ejemplo.com",
            "1234", // será hasheado a MD5
            "USER"
        );
        
        boolean creado = dao.crearUsuario(nuevoUsuario);
        System.out.println("   Usuario creado: " + (creado ? "✅ Éxito" : "❌ Fallo"));
        
        if (creado) {
            // 2.3 Listar usuarios después de crear
            System.out.println("\n2.3 Listando usuarios después de crear:");
            List<Usuario> usuariosDespues = dao.listarUsuarios();
            System.out.println("   Total usuarios: " + usuariosDespues.size());
            
            // 2.4 Buscar el usuario creado (asumimos que es el último)
            if (!usuariosDespues.isEmpty()) {
                Usuario ultimoUsuario = usuariosDespues.get(usuariosDespues.size() - 1);
                System.out.println("\n2.4 Buscando último usuario por ID " + ultimoUsuario.getIdUsuario() + ":");
                Usuario encontrado = dao.buscarUsuarioPorId(ultimoUsuario.getIdUsuario());
                if (encontrado != null) {
                    System.out.println("   ✅ Usuario encontrado: " + encontrado.getNombre());
                    
                    // 2.5 Actualizar el usuario
                    System.out.println("\n2.5 Actualizando usuario:");
                    encontrado.setNombre(encontrado.getNombre() + " (Actualizado)");
                    boolean actualizado = dao.actualizarUsuario(encontrado);
                    System.out.println("   Usuario actualizado: " + (actualizado ? "✅ Éxito" : "❌ Fallo"));
                    
                    // 2.6 Eliminar el usuario
                    System.out.println("\n2.6 Eliminando usuario:");
                    boolean eliminado = dao.eliminarUsuario(encontrado.getIdUsuario());
                    System.out.println("   Usuario eliminado: " + (eliminado ? "✅ Éxito" : "❌ Fallo"));
                } else {
                    System.out.println("   ❌ Usuario no encontrado");
                }
            }
        }
        
        // 2.7 Listado final
        System.out.println("\n2.7 Listado final de usuarios:");
        List<Usuario> usuariosFinal = dao.listarUsuarios();
        System.out.println("   Total usuarios final: " + usuariosFinal.size());
    }
}
