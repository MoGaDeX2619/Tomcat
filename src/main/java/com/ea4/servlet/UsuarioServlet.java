package com.ea4.servlet;

import com.ea4.dao.UsuarioDAO;
import com.ea4.model.Usuario;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO usuarioDAO;
    
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        try {
            switch (accion == null ? "listar" : accion) {
                case "crear":
                    crearUsuario(request, response);
                    break;
                case "actualizar":
                    actualizarUsuario(request, response);
                    break;
                case "editar":
                    mostrarFormularioEditar(request, response);
                    break;
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                case "buscar":
                    buscarUsuarios(request, response);
                    break;
                default:
                    listarUsuarios(request, response);
                    break;
            }
        } catch (Exception ex) {
            System.err.println("Error en UsuarioServlet: " + ex.getMessage());
            request.setAttribute("mensaje", "Error interno del servidor: " + ex.getMessage());
            request.setAttribute("mensajeTipo", "error");
            listarUsuarios(request, response);
        }
    }
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<String> errores = validarUsuario(request, -1);
        
        if (!errores.isEmpty()) {
            request.setAttribute("errores", errores);
            request.setAttribute("mensaje", "Por favor corrija los errores en el formulario");
            request.setAttribute("mensajeTipo", "error");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/crear-usuario.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        Usuario usuario = new Usuario();
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(request.getParameter("email"));
        usuario.setTelefono(request.getParameter("telefono"));
        usuario.setDireccion(request.getParameter("direccion"));
        
        // Verificar si el email ya existe
        if (usuarioDAO.existeEmail(usuario.getEmail(), -1)) {
            request.setAttribute("mensaje", "El email ya está registrado por otro usuario");
            request.setAttribute("mensajeTipo", "error");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/crear-usuario.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        if (usuarioDAO.crearUsuario(usuario)) {
            request.setAttribute("mensaje", "Usuario creado exitosamente");
            request.setAttribute("mensajeTipo", "success");
            response.sendRedirect("usuarios?mensaje=Usuario creado exitosamente&tipo=success");
        } else {
            request.setAttribute("mensaje", "Error al crear el usuario");
            request.setAttribute("mensajeTipo", "error");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/crear-usuario.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        List<String> errores = validarUsuario(request, id);
        
        if (!errores.isEmpty()) {
            request.setAttribute("errores", errores);
            request.setAttribute("mensaje", "Por favor corrija los errores en el formulario");
            request.setAttribute("mensajeTipo", "error");
            
            // Recargar el usuario para mostrar en el formulario
            Usuario usuario = usuarioDAO.obtenerUsuarioPorId(id);
            request.setAttribute("usuarioEditar", usuario);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        Usuario usuario = usuarioDAO.obtenerUsuarioPorId(id);
        if (usuario == null) {
            request.setAttribute("mensaje", "Usuario no encontrado");
            request.setAttribute("mensajeTipo", "error");
            response.sendRedirect("usuarios?mensaje=Usuario no encontrado&tipo=error");
            return;
        }
        
        // Verificar si el email ya existe (excluyendo el usuario actual)
        String nuevoEmail = request.getParameter("email");
        if (!usuario.getEmail().equals(nuevoEmail) && usuarioDAO.existeEmail(nuevoEmail, id)) {
            request.setAttribute("mensaje", "El email ya está registrado por otro usuario");
            request.setAttribute("mensajeTipo", "error");
            request.setAttribute("usuarioEditar", usuario);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(nuevoEmail);
        usuario.setTelefono(request.getParameter("telefono"));
        usuario.setDireccion(request.getParameter("direccion"));
        
        if (usuarioDAO.actualizarUsuario(usuario)) {
            response.sendRedirect("usuarios?mensaje=Usuario actualizado exitosamente&tipo=success");
        } else {
            request.setAttribute("mensaje", "Error al actualizar el usuario");
            request.setAttribute("mensajeTipo", "error");
            request.setAttribute("usuarioEditar", usuario);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usuario = usuarioDAO.obtenerUsuarioPorId(id);
        
        if (usuario == null) {
            request.setAttribute("mensaje", "Usuario no encontrado");
            request.setAttribute("mensajeTipo", "error");
            listarUsuarios(request, response);
        } else {
            request.setAttribute("usuarioEditar", usuario);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (usuarioDAO.eliminarUsuario(id)) {
            response.sendRedirect("usuarios?mensaje=Usuario eliminado exitosamente&tipo=success");
        } else {
            response.sendRedirect("usuarios?mensaje=Error al eliminar el usuario&tipo=error");
        }
    }
    
    private void buscarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String termino = request.getParameter("termino");
        
        if (termino == null || termino.trim().isEmpty()) {
            listarUsuarios(request, response);
            return;
        }
        
        List<Usuario> usuarios = usuarioDAO.buscarUsuariosPorNombre(termino.trim());
        request.setAttribute("usuarios", usuarios);
        request.setAttribute("termino", termino);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Usuario> usuarios = usuarioDAO.obtenerTodosLosUsuarios();
        request.setAttribute("usuarios", usuarios);
        
        // Manejar mensajes de redirección
        String mensaje = request.getParameter("mensaje");
        String tipo = request.getParameter("tipo");
        
        if (mensaje != null && tipo != null) {
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("mensajeTipo", tipo);
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/editar-usuario.jsp");
        dispatcher.forward(request, response);
    }
    
    private List<String> validarUsuario(HttpServletRequest request, int excludeId) {
        List<String> errores = new ArrayList<>();
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        
        // Validación del nombre
        if (nombre == null || nombre.trim().isEmpty()) {
            errores.add("El nombre es obligatorio");
        } else if (nombre.trim().length() < 3) {
            errores.add("El nombre debe tener al menos 3 caracteres");
        } else if (nombre.trim().length() > 50) {
            errores.add("El nombre no puede tener más de 50 caracteres");
        }
        
        // Validación del apellido
        if (apellido == null || apellido.trim().isEmpty()) {
            errores.add("El apellido es obligatorio");
        } else if (apellido.trim().length() < 3) {
            errores.add("El apellido debe tener al menos 3 caracteres");
        } else if (apellido.trim().length() > 50) {
            errores.add("El apellido no puede tener más de 50 caracteres");
        }
        
        // Validación del email
        if (email == null || email.trim().isEmpty()) {
            errores.add("El email es obligatorio");
        } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            errores.add("El formato del email no es válido");
        } else if (email.length() > 100) {
            errores.add("El email no puede tener más de 100 caracteres");
        }
        
        // Validación del teléfono
        if (telefono == null || telefono.trim().isEmpty()) {
            errores.add("El teléfono es obligatorio");
        } else if (!telefono.matches("^[0-9]{8,15}$")) {
            errores.add("El teléfono debe contener solo números y tener entre 8 y 15 dígitos");
        }
        
        // Validación de la dirección
        if (direccion == null || direccion.trim().isEmpty()) {
            errores.add("La dirección es obligatoria");
        } else if (direccion.trim().length() < 5) {
            errores.add("La dirección debe tener al menos 5 caracteres");
        } else if (direccion.trim().length() > 200) {
            errores.add("La dirección no puede tener más de 200 caracteres");
        }
        
        return errores;
    }
}
