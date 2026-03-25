package com.mycompany.modelo;

/**
 * Clase modelo que representa un usuario
 * @author Nelson Diaz
 */
public class Usuario {
    
    private int idUsuario;
    private String nombre;
    private String correo;
    private String contrasena;
    private String rol;
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor con parámetros (sin id para creación)
    public Usuario(String nombre, String correo, String contrasena, String rol) {
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
    }
    
    // Constructor completo
    public Usuario(int idUsuario, String nombre, String correo, String contrasena, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
    }
    
    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getCorreo() {
        return correo;
    }
    
    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public String getContrasena() {
        return contrasena;
    }
    
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    
    public String getRol() {
        return rol;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
    
    @Override
    public String toString() {
        return "Usuario{" + "idUsuario=" + idUsuario + ", nombre=" + nombre + 
               ", correo=" + correo + ", rol=" + rol + '}';
    }
}
