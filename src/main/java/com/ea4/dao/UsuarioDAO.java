package com.ea4.dao;

import com.ea4.model.Usuario;
import com.ea4.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    
    public boolean crearUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nombre, apellido, email, telefono, direccion, fecha_creacion, fecha_actualizacion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, usuario.getNombre());
            pstmt.setString(2, usuario.getApellido());
            pstmt.setString(3, usuario.getEmail());
            pstmt.setString(4, usuario.getTelefono());
            pstmt.setString(5, usuario.getDireccion());
            pstmt.setTimestamp(6, Timestamp.valueOf(usuario.getFechaCreacion()));
            pstmt.setTimestamp(7, Timestamp.valueOf(usuario.getFechaActualizacion()));
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        usuario.setId(rs.getInt(1));
                    }
                }
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error al crear usuario: " + e.getMessage());
        }
        
        return false;
    }
    
    public Usuario obtenerUsuarioPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapearResultSetAUsuario(rs);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener usuario por ID: " + e.getMessage());
        }
        
        return null;
    }
    
    public List<Usuario> obtenerTodosLosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY fecha_creacion DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                usuarios.add(mapearResultSetAUsuario(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener todos los usuarios: " + e.getMessage());
        }
        
        return usuarios;
    }
    
    public List<Usuario> buscarUsuariosPorNombre(String nombre) {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE nombre LIKE ? OR apellido LIKE ? ORDER BY nombre";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchTerm = "%" + nombre + "%";
            pstmt.setString(1, searchTerm);
            pstmt.setString(2, searchTerm);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    usuarios.add(mapearResultSetAUsuario(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar usuarios por nombre: " + e.getMessage());
        }
        
        return usuarios;
    }
    
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET nombre = ?, apellido = ?, email = ?, telefono = ?, " +
                     "direccion = ?, fecha_actualizacion = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, usuario.getNombre());
            pstmt.setString(2, usuario.getApellido());
            pstmt.setString(3, usuario.getEmail());
            pstmt.setString(4, usuario.getTelefono());
            pstmt.setString(5, usuario.getDireccion());
            pstmt.setTimestamp(6, Timestamp.valueOf(usuario.getFechaActualizacion()));
            pstmt.setInt(7, usuario.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean existeEmail(String email, int excludeId) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ? AND id != ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setInt(2, excludeId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al verificar existencia de email: " + e.getMessage());
        }
        
        return false;
    }
    
    private Usuario mapearResultSetAUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setId(rs.getInt("id"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setApellido(rs.getString("apellido"));
        usuario.setEmail(rs.getString("email"));
        usuario.setTelefono(rs.getString("telefono"));
        usuario.setDireccion(rs.getString("direccion"));
        
        Timestamp fechaCreacion = rs.getTimestamp("fecha_creacion");
        if (fechaCreacion != null) {
            usuario.setFechaCreacion(fechaCreacion.toLocalDateTime());
        }
        
        Timestamp fechaActualizacion = rs.getTimestamp("fecha_actualizacion");
        if (fechaActualizacion != null) {
            usuario.setFechaActualizacion(fechaActualizacion.toLocalDateTime());
        }
        
        return usuario;
    }
}
