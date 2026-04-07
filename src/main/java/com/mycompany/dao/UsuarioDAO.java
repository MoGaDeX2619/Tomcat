package com.mycompany.dao;

import com.mycompany.conexion.ConexionDB;
import com.mycompany.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase DAO para operaciones CRUD de usuarios
 * @author Nelson Diaz
 */
public class UsuarioDAO {
    
    /**
     * Verifica si un ID de usuario ya existe en la base de datos
     * @param idUsuario ID a verificar
     * @return true si el ID ya existe, false si está disponible
     */
    public boolean existeID(int idUsuario) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE idUsuario = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Verificando si existe ID: " + idUsuario);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, idUsuario);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        boolean existe = count > 0;
                        System.out.println("ID " + idUsuario + " existe: " + existe);
                        return existe;
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al verificar ID: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return false;
    }
    
    /**
     * Verifica si un correo electrónico ya existe en la base de datos
     * @param correo Correo a verificar
     * @return true si el correo ya existe, false si está disponible
     */
    public boolean existeCorreo(String correo) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Verificando si existe correo: " + correo);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, correo);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        boolean existe = count > 0;
                        System.out.println("Correo " + correo + " existe: " + existe);
                        return existe;
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al verificar correo: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return false;
    }
    
    /**
     * Crea un nuevo usuario en la base de datos con ID personalizado
     * @param u objeto Usuario a crear (con ID generado)
     * @return true si se creó exitosamente, false en caso contrario
     */
    public boolean crearUsuario(Usuario u) {
        String sql = "INSERT INTO usuarios (idUsuario, nombre, correo, contrasena, cedula, fecha_nacimiento, rol) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Creando usuario - Nombre: " + u.getNombre() + ", Correo: " + u.getCorreo() + ", ID: " + u.getIdUsuario());
            
            // Verificar si el correo ya existe
            if (existeCorreo(u.getCorreo())) {
                System.out.println("Error: El correo ya está registrado");
                return false;
            }
            
            // Verificar si la cédula ya existe
            if (existeCedula(u.getCedula())) {
                System.out.println("Error: La cédula ya está registrada");
                return false;
            }
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, u.getIdUsuario());
                pstmt.setString(2, u.getNombre());
                pstmt.setString(3, u.getCorreo());
                pstmt.setString(4, u.getContrasena());
                pstmt.setString(5, u.getCedula());
                pstmt.setString(6, u.getFechaNacimiento());
                pstmt.setString(7, u.getRol());
                
                int filasAfectadas = pstmt.executeUpdate();
                System.out.println("Filas afectadas al crear usuario: " + filasAfectadas);
                
                return filasAfectadas > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al crear usuario: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return false;
    }
    
    /**
     * Verifica si una cédula ya existe en la base de datos
     * @param cedula Cédula a verificar
     * @return true si la cédula ya existe, false si está disponible
     */
    public boolean existeCedula(String cedula) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE cedula = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Verificando si existe cédula: " + cedula);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, cedula);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        boolean existe = count > 0;
                        System.out.println("Cédula " + cedula + " existe: " + existe);
                        return existe;
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al verificar cédula: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return false;
    }
    
    /**
     * Crea un nuevo usuario en la base de datos con ID específico (método legacy)
     * @param u objeto Usuario a crear (puede incluir ID)
     * @return true si se creó exitosamente, false en caso contrario
     */
    public boolean crearUsuarioConID(Usuario u) {
        String sql;
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Creando usuario con ID - ID: " + u.getIdUsuario() + ", Nombre: " + u.getNombre() + ", Correo: " + u.getCorreo());
            
            // Verificar si el correo ya existe
            if (existeCorreo(u.getCorreo())) {
                System.out.println("Error: El correo ya está registrado");
                return false;
            }
            
            if (u.getIdUsuario() > 0) {
                // Verificar si el ID ya existe
                if (existeID(u.getIdUsuario())) {
                    System.out.println("Error: El ID ya está en uso");
                    return false;
                }
                
                // Insertar con ID específico
                sql = "INSERT INTO usuarios (idUsuario, nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, u.getIdUsuario());
                    pstmt.setString(2, u.getNombre());
                    pstmt.setString(3, u.getCorreo());
                    pstmt.setString(4, u.getContrasena());
                    pstmt.setString(5, u.getRol());
                    
                    int filasAfectadas = pstmt.executeUpdate();
                    System.out.println("Filas afectadas al crear usuario con ID: " + filasAfectadas);
                    return filasAfectadas > 0;
                }
            } else {
                // Insertar con AUTO_INCREMENT (método original)
                sql = "INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, u.getNombre());
                    pstmt.setString(2, u.getCorreo());
                    pstmt.setString(3, u.getContrasena());
                    pstmt.setString(4, u.getRol());
                    
                    int filasAfectadas = pstmt.executeUpdate();
                    System.out.println("Filas afectadas al crear usuario auto: " + filasAfectadas);
                    return filasAfectadas > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al crear usuario con ID: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
    }
    
    /**
     * Elimina un usuario por su correo electrónico (para pruebas)
     * @param correo correo del usuario a eliminar
     * @return true si se eliminó exitosamente, false en caso contrario
     */
    public boolean eliminarUsuarioPorCorreo(String correo) {
        String sql = "DELETE FROM usuarios WHERE correo = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Eliminando usuario por correo: " + correo);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, correo);
                
                int filasAfectadas = pstmt.executeUpdate();
                System.out.println("Filas afectadas al eliminar usuario por correo: " + filasAfectadas);
                return filasAfectadas > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al eliminar usuario por correo: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return false;
    }
    
    /**
     * Obtiene la lista de todos los usuarios
     * @return Lista de usuarios
     */
    public List<Usuario> listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY idUsuario";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Listando usuarios de la base de datos...");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setCedula(rs.getString("cedula"));
                    usuario.setFechaNacimiento(rs.getString("fecha_nacimiento"));
                    
                    usuarios.add(usuario);
                    System.out.println("Usuario encontrado: " + usuario.getNombre());
                }
                
                System.out.println("Total de usuarios encontrados: " + usuarios.size());
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al listar usuarios: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return usuarios;
    }
    
    /**
     * Actualiza un usuario existente
     * @param u objeto Usuario con los datos actualizados
     * @return true si se actualizó exitosamente, false en caso contrario
     */
    public boolean actualizarUsuario(Usuario u) {
        String sql = "UPDATE usuarios SET nombre = ?, correo = ?, contrasena = ?, rol = ? WHERE idUsuario = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Actualizando usuario ID: " + u.getIdUsuario() + ", Nombre: " + u.getNombre());
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, u.getNombre());
                pstmt.setString(2, u.getCorreo());
                pstmt.setString(3, u.getContrasena());
                pstmt.setString(4, u.getRol());
                pstmt.setInt(5, u.getIdUsuario());
                
                int filasAfectadas = pstmt.executeUpdate();
                System.out.println("Filas afectadas al actualizar usuario: " + filasAfectadas);
                return filasAfectadas > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al actualizar usuario: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
    }
    
    /**
     * Elimina un usuario por su ID
     * @param id ID del usuario a eliminar
     * @return true si se eliminó exitosamente, false en caso contrario
     */
    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE idUsuario = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Eliminando usuario con ID: " + id);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                
                int filasAfectadas = pstmt.executeUpdate();
                System.out.println("Filas afectadas al eliminar usuario: " + filasAfectadas);
                return filasAfectadas > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al eliminar usuario: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
    }
    
    /**
     * Busca un usuario por su ID
     * @param id ID del usuario a buscar
     * @return objeto Usuario si lo encuentra, null en caso contrario
     */
    public Usuario buscarUsuarioPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE idUsuario = ?";
        Connection conn = null;
        
        try {
            conn = ConexionDB.getConexion();
            System.out.println("Buscando usuario con ID: " + id);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        Usuario usuario = new Usuario();
                        usuario.setIdUsuario(rs.getInt("idUsuario"));
                        usuario.setNombre(rs.getString("nombre"));
                        usuario.setCorreo(rs.getString("correo"));
                        usuario.setContrasena(rs.getString("contrasena"));
                        usuario.setRol(rs.getString("rol"));
                        
                        System.out.println("Usuario encontrado: " + usuario.getNombre());
                        return usuario;
                    }
                }
            }
            
            System.out.println("No se encontró usuario con ID: " + id);
            
        } catch (SQLException e) {
            System.err.println("Error SQL al buscar usuario por ID: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            ConexionDB.cerrarConexion(conn);
        }
        
        return null;
    }
}
