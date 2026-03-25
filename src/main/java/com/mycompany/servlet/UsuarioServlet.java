package com.mycompany.servlet;

import com.mycompany.dao.UsuarioDAO;
import com.mycompany.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet para manejar operaciones CRUD de usuarios
 * @author Nelson Diaz
 */
// Mapeo del servlet con la anotación para Jakarta EE 10
@WebServlet("/usuario") 
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
            case "editar":
                mostrarFormularioEditar(request, response);
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
        
        List<Usuario> usuarios = usuarioDAO.listarUsuarios();
        request.setAttribute("usuarios", usuarios);
        
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
        
        // Convertir contraseña a MD5 antes de validar
        String contrasenaHasheada = convertirMD5(contrasena);
        
        List<String> errores = validarUsuario(nombre, correo, contrasena, rol);
        
        if (!errores.isEmpty()) {
            request.setAttribute("errores", errores);
            // Se pasa un objeto temporal para no perder los datos escritos en el form
            request.setAttribute("usuario", new Usuario(0, nombre, correo, contrasena, rol));
            request.getRequestDispatcher("/crear.jsp").forward(request, response);
            return;
        }
        
        Usuario usuario = new Usuario(nombre, correo, contrasenaHasheada, rol);
        
        if (usuarioDAO.crearUsuario(usuario)) {
            request.setAttribute("mensaje", "Usuario creado exitosamente");
            request.setAttribute("tipoMensaje", "exito");
        } else {
            request.setAttribute("mensaje", "Error al crear el usuario");
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
            
            // Convertir contraseña a MD5 antes de validar
            String contrasenaHasheada = convertirMD5(contrasena);
            
            List<String> errores = validarUsuario(nombre, correo, contrasena, rol);
            
            if (!errores.isEmpty()) {
                request.setAttribute("errores", errores);
                request.setAttribute("usuario", new Usuario(idUsuario, nombre, correo, contrasena, rol));
                request.getRequestDispatcher("/editar.jsp").forward(request, response);
                return;
            }
            
            Usuario usuario = new Usuario(idUsuario, nombre, correo, contrasenaHasheada, rol);
            
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
    
    private List<String> validarUsuario(String nombre, String correo, String contrasena, String rol) {
        // Ahora sí funcionará porque importamos java.util.ArrayList
        List<String> errores = new ArrayList<>();
        
        if (nombre == null || nombre.trim().isEmpty()) {
            errores.add("El nombre no puede estar vacío");
        }
        
        if (correo == null || correo.trim().isEmpty()) {
            errores.add("El correo no puede estar vacío");
        } else if (!correo.contains("@") || !correo.contains(".")) {
            errores.add("El correo debe tener un formato válido (contener @ y .)");
        }
        
        if (contrasena == null || contrasena.trim().isEmpty()) {
            errores.add("La contraseña no puede estar vacía");
        } else if (contrasena.length() < 4) {
            errores.add("La contraseña debe tener al menos 4 caracteres");
        }
        
        if (rol == null || rol.trim().isEmpty()) {
            errores.add("El rol no puede estar vacío");
        }
        
        return errores;
    }
    
    /**
     * Convierte una cadena a su representación en MD5
     * @param texto cadena a convertir
     * @return hash MD5 en formato hexadecimal
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