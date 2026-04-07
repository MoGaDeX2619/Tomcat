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
    private String cedula;
    private String fechaNacimiento; // Cambiado a String para compatibilidad con BD
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor con parámetros (sin id para creación)
    public Usuario(String nombre, String correo, String contrasena, String rol, String cedula, String fechaNacimiento) {
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
        this.cedula = cedula;
        this.fechaNacimiento = fechaNacimiento;
    }
    
    // Constructor completo
    public Usuario(int idUsuario, String nombre, String correo, String contrasena, String rol, String cedula, String fechaNacimiento) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
        this.cedula = cedula;
        this.fechaNacimiento = fechaNacimiento;
    }
    
    // Constructor legacy (para compatibilidad)
    public Usuario(int idUsuario, String nombre, String correo, String contrasena, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
        this.cedula = null;
        this.fechaNacimiento = null;
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
    
    public String getCedula() {
        return cedula;
    }
    
    public void setCedula(String cedula) {
        this.cedula = cedula;
    }
    
    public String getFechaNacimiento() {
        return fechaNacimiento;
    }
    
    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    
    @Override
    public String toString() {
        return "Usuario{" + "idUsuario=" + idUsuario + ", nombre=" + nombre + 
               ", correo=" + correo + ", rol=" + rol + 
               ", cedula=" + cedula + ", fechaNacimiento=" + fechaNacimiento + '}';
    }
}
