package com.mycompany.servlet;

import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;
import com.mycompany.util.GeneradorID;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet principal para manejar las operaciones de usuarios
 * @author Nelson Diaz
 */
public class UsuarioServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "listar":
                listarUsuarios(request, response);
                break;
            case "crear":
                crearUsuario(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "actualizar":
                actualizarUsuario(request, response);
                break;
            case "eliminar":
                eliminarUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "crear";
        }
        
        switch (accion) {
            case "crear":
                crearUsuario(request, response);
                break;
            case "actualizar":
                actualizarUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
                break;
        }
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("Listando usuarios...");
        List<Usuario> usuarios = usuarioDAO.listarUsuarios();
        request.setAttribute("usuarios", usuarios);
        
        System.out.println("Total de usuarios a mostrar en JSP: " + (usuarios != null ? usuarios.size() : 0));
        
        // El forward debe ser el final del método
        request.getRequestDispatcher("/listar.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Usuario usuario = usuarioDAO.buscarUsuarioPorId(id);
            
            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/editar.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Usuario no encontrado");
                request.setAttribute("tipoMensaje", "error");
                listarUsuarios(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de usuario inválido");
            request.setAttribute("tipoMensaje", "error");
            listarUsuarios(request, response);
        }
    }
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");
        String cedula = request.getParameter("cedula");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        
        System.out.println("=== CREANDO USUARIO CON ID PERSONALIZADO ===");
        System.out.println("Nombre: " + nombre);
        System.out.println("Correo: " + correo);
        System.out.println("Rol: " + rol);
        System.out.println("Cédula: " + cedula);
        System.out.println("Fecha Nacimiento: " + fechaNacimiento);
        
        // Validar parámetros
        if (nombre == null || correo == null || contrasena == null || rol == null || cedula == null || fechaNacimiento == null) {
            request.setAttribute("mensaje", "Todos los campos son obligatorios");
            request.setAttribute("tipoMensaje", "error");
            listarUsuarios(request, response);
            return;
        }
        
        // Validar datos del usuario
        List<String> errores = validarUsuario(nombre, correo, contrasena, rol, cedula, fechaNacimiento);
        if (!errores.isEmpty()) {
            request.setAttribute("errores", errores);
            request.setAttribute("mensaje", "Por favor corrige los errores del formulario");
            request.setAttribute("tipoMensaje", "error");
            
            // Crear objeto usuario para mantener los datos en el formulario
            Usuario usuarioTemporal = new Usuario(0, nombre, correo, contrasena, rol, cedula, fechaNacimiento);
            request.setAttribute("usuario", usuarioTemporal);
            
            request.getRequestDispatcher("crear.jsp").forward(request, response);
            return;
        }
        
        // Generar ID personalizado basado en cédula y fecha de nacimiento
        String idPersonalizado;
        int idUsuario;
        try {
            // Limpiar cédula
            String cedulaLimpia = GeneradorID.limpiarCedula(cedula);
            idPersonalizado = GeneradorID.generarIDPersonalizado(cedulaLimpia, fechaNacimiento);
            idUsuario = GeneradorID.convertirIDANumero(idPersonalizado);
            
            System.out.println("ID generado personalizado: " + idPersonalizado + " (número: " + idUsuario + ")");
            
            // Verificar si el ID ya existe
            if (usuarioDAO.existeID(idUsuario)) {
                request.setAttribute("mensaje", "El ID generado " + idPersonalizado + " ya está en uso. Intenta con otra cédula o fecha.");
                request.setAttribute("tipoMensaje", "error");
                listarUsuarios(request, response);
                return;
            }
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("mensaje", "Error al generar ID: " + e.getMessage());
            request.setAttribute("tipoMensaje", "error");
            listarUsuarios(request, response);
            return;
        }
        
        // Hashear la contraseña
        String contrasenaHasheada = convertirMD5(contrasena);
        
        // Crear objeto usuario con ID personalizado
        Usuario usuario = new Usuario(idUsuario, nombre, correo, contrasenaHasheada, rol, cedula, fechaNacimiento);
        
        System.out.println("Llamando a usuarioDAO.crearUsuario() con ID personalizado");
        boolean creado = usuarioDAO.crearUsuario(usuario);
        
        if (creado) {
            System.out.println("Usuario creado exitosamente con ID personalizado: " + idPersonalizado);
            request.setAttribute("mensaje", "¡Usuario agregado correctamente! ID asignado: " + idPersonalizado);
            request.setAttribute("tipoMensaje", "exito");
        } else {
            System.out.println("Error al crear el usuario");
            // Verificar si el error fue por correo duplicado
            if (usuarioDAO.existeCorreo(correo)) {
                request.setAttribute("mensaje", "No se pudo crear: El correo electrónico ya está registrado. Usa otro correo.");
            } else if (usuarioDAO.existeCedula(cedula)) {
                request.setAttribute("mensaje", "No se pudo crear: La cédula ya está registrada. Usa otra cédula.");
            } else {
                request.setAttribute("mensaje", "Ocurrió un error al guardar el usuario. Intenta de nuevo.");
            }
            request.setAttribute("tipoMensaje", "error");
        }
        
        listarUsuarios(request, response);
    }
    
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String rol = request.getParameter("rol");
            String cedula = request.getParameter("cedula");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            
            // Convertir contraseña a MD5 antes de validar
            String contrasenaHasheada = convertirMD5(contrasena);
            
            List<String> errores = validarUsuario(nombre, correo, contrasena, rol, cedula, fechaNacimiento);
            
            if (!errores.isEmpty()) {
                request.setAttribute("errores", errores);
                request.setAttribute("usuario", new Usuario(idUsuario, nombre, correo, contrasena, rol, cedula, fechaNacimiento));
                request.getRequestDispatcher("/editar.jsp").forward(request, response);
                return;
            }
            
            Usuario usuario = new Usuario(idUsuario, nombre, correo, contrasenaHasheada, rol, cedula, fechaNacimiento);
            
            if (usuarioDAO.actualizarUsuario(usuario)) {
                request.setAttribute("mensaje", "Usuario actualizado exitosamente");
                request.setAttribute("tipoMensaje", "exito");
            } else {
                request.setAttribute("mensaje", "Error al actualizar el usuario");
                request.setAttribute("tipoMensaje", "error");
            }
            
            listarUsuarios(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de usuario inválido");
            request.setAttribute("tipoMensaje", "error");
            listarUsuarios(request, response);
        }
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                if (usuarioDAO.eliminarUsuario(id)) {
                    request.setAttribute("mensaje", "Usuario eliminado exitosamente");
                    request.setAttribute("tipoMensaje", "exito");
                } else {
                    request.setAttribute("mensaje", "Error al eliminar el usuario");
                    request.setAttribute("tipoMensaje", "error");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de usuario inválido");
            request.setAttribute("tipoMensaje", "error");
        }
        
        listarUsuarios(request, response);
    }
    
    private List<String> validarUsuario(String nombre, String correo, String contrasena, String rol, String cedula, String fechaNacimiento) {
        // Ahora sí funcionará porque importamos java.util.ArrayList
        List<String> errores = new ArrayList<>();
        
        if (nombre == null || nombre.trim().isEmpty()) {
            errores.add("El nombre es obligatorio");
        }
        
        if (correo == null || correo.trim().isEmpty()) {
            errores.add("El correo es obligatorio");
        } else if (!correo.contains("@") || !correo.contains(".")) {
            errores.add("El correo no es válido (debe tener @ y .)");
        }
        
        if (contrasena == null || contrasena.trim().isEmpty()) {
            errores.add("La contraseña es obligatoria");
        } else {
            // Validar longitud mínima
            if (contrasena.length() < 6) {
                errores.add("La contraseña necesita al menos 6 caracteres");
            }
            
            // Validar que tenga al menos una mayúscula
            if (!contrasena.matches(".*[A-Z].*")) {
                errores.add("La contraseña debe tener una letra mayúscula");
            }
            
            // Validar que tenga al menos un número
            if (!contrasena.matches(".*[0-9].*")) {
                errores.add("La contraseña debe tener un número");
            }
            
            // Validar que tenga al menos un símbolo
            if (!contrasena.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*")) {
                errores.add("La contraseña debe tener un símbolo (!@#$%^&*)");
            }
        }
        
        if (rol == null || rol.trim().isEmpty()) {
            errores.add("Debes seleccionar un tipo de usuario");
        }
        
        // Validar cédula
        if (cedula == null || cedula.trim().isEmpty()) {
            errores.add("La cédula es obligatoria");
        } else if (!GeneradorID.validarCedula(cedula)) {
            errores.add("La cédula debe tener al menos 4 dígitos");
        }
        
        // Validar fecha de nacimiento
        if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) {
            errores.add("La fecha de nacimiento es obligatoria");
        } else if (!GeneradorID.validarFechaNacimiento(fechaNacimiento)) {
            errores.add("La fecha de nacimiento no es válida (use formato YYYY-MM-DD)");
        }
        
        return errores;
    }
    
    /**
     * Genera el hash MD5 de una contraseña
     * @param texto la contraseña a convertir
     * @return el hash en formato hexadecimal
     */
    private String convertirMD5(String texto) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(texto.getBytes());
            StringBuilder sb = new StringBuilder();
            
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Error al generar MD5: " + e.getMessage());
            return texto; // En caso de error, devuelve el texto original
        }
    }
}