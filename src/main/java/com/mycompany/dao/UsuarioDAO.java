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
     * Crea un nuevo usuario en la base de datos
     * @param u objeto Usuario a crear
     * @return true si se creó exitosamente, false en caso contrario
     */
    public boolean crearUsuario(Usuario u) {
        String sql = "INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, u.getNombre());
            pstmt.setString(2, u.getCorreo());
            pstmt.setString(3, u.getContrasena());
            pstmt.setString(4, u.getRol());
            
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al crear usuario: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Obtiene la lista de todos los usuarios
     * @return Lista de usuarios
     */
    public List<Usuario> listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY idUsuario";
        
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setRol(rs.getString("rol"));
                
                usuarios.add(usuario);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios: " + e.getMessage());
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
        
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, u.getNombre());
            pstmt.setString(2, u.getCorreo());
            pstmt.setString(3, u.getContrasena());
            pstmt.setString(4, u.getRol());
            pstmt.setInt(5, u.getIdUsuario());
            
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Elimina un usuario por su ID
     * @param id ID del usuario a eliminar
     * @return true si se eliminó exitosamente, false en caso contrario
     */
    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE idUsuario = ?";
        
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Busca un usuario por su ID
     * @param id ID del usuario a buscar
     * @return objeto Usuario si lo encuentra, null en caso contrario
     */
    public Usuario buscarUsuarioPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE idUsuario = ?";
        
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setRol(rs.getString("rol"));
                    
                    return usuario;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por ID: " + e.getMessage());
        }
        
        return null;
    }
}
