package com.mycompany.util;

/**
 * Utilidad para generar IDs de usuario basados en cédula y fecha de nacimiento
 * @author Nelson Diaz
 */
public class GeneradorID {
    
    /**
     * Genera un ID único basado en la cédula y el año de nacimiento
     * Fórmula: Últimos 4 dígitos de cédula + Últimos 2 dígitos del año de nacimiento
     * @param cedula Cédula del usuario (ej: "00123456789")
     * @param fechaNacimiento Fecha de nacimiento como String (ej: "1990-01-15")
     * @return ID generado (ej: "678990" para cédula "00123456789" y año 1990)
     */
    public static String generarIDPersonalizado(String cedula, String fechaNacimiento) {
        if (cedula == null || cedula.length() < 4 || fechaNacimiento == null) {
            throw new IllegalArgumentException("Cédula y fecha de nacimiento son obligatorios");
        }
        
        // Obtener últimos 4 dígitos de la cédula
        String ultimos4Cedula = cedula.length() >= 4 ? 
            cedula.substring(cedula.length() - 4) : cedula;
        
        // Extraer el año de la fecha (asumiendo formato YYYY-MM-DD)
        String anio = "";
        if (fechaNacimiento.length() >= 4) {
            anio = fechaNacimiento.substring(0, 4);
        } else {
            throw new IllegalArgumentException("Formato de fecha inválido. Use YYYY-MM-DD");
        }
        
        // Validar que el año sea numérico
        try {
            Integer.parseInt(anio);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("El año debe ser numérico");
        }
        
        // Obtener últimos 2 dígitos del año de nacimiento
        String ultimos2Anio = anio.length() >= 2 ? 
            anio.substring(anio.length() - 2) : anio;
        
        // Combinar para formar el ID
        String idGenerado = ultimos4Cedula + ultimos2Anio;
        
        System.out.println("ID generado - Cédula: " + cedula + " → " + ultimos4Cedula + 
                          ", Año: " + anio + " → " + ultimos2Anio + ", ID: " + idGenerado);
        
        return idGenerado;
    }
    
    /**
     * Convierte el ID generado a número entero para almacenamiento
     * @param idPersonalizado ID generado como cadena
     * @return ID como número entero
     */
    public static int convertirIDANumero(String idPersonalizado) {
        try {
            return Integer.parseInt(idPersonalizado);
        } catch (NumberFormatException e) {
            System.err.println("Error al convertir ID a número: " + idPersonalizado);
            return 0;
        }
    }
    
    /**
     * Valida el formato de la cédula (debe tener al menos 4 dígitos)
     * @param cedula Cédula a validar
     * @return true si es válida, false en caso contrario
     */
    public static boolean validarCedula(String cedula) {
        if (cedula == null || cedula.trim().isEmpty()) {
            return false;
        }
        
        // Eliminar espacios y caracteres no numéricos
        String cedulaLimpia = cedula.replaceAll("[^0-9]", "");
        
        // Debe tener entre 4 y 20 dígitos
        return cedulaLimpia.length() >= 4 && cedulaLimpia.length() <= 20;
    }
    
    /**
     * Limpia y formatea la cédula
     * @param cedula Cédula original
     * @return Cédula limpia (solo números)
     */
    public static String limpiarCedula(String cedula) {
        if (cedula == null) {
            return "";
        }
        return cedula.replaceAll("[^0-9]", "");
    }
    
    /**
     * Valida que la fecha de nacimiento sea razonable (no futura, no muy antigua)
     * @param fechaNacimiento Fecha a validar como String (YYYY-MM-DD)
     * @return true si es válida, false en caso contrario
     */
    public static boolean validarFechaNacimiento(String fechaNacimiento) {
        if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) {
            return false;
        }
        
        try {
            // Validar formato básico YYYY-MM-DD
            if (!fechaNacimiento.matches("\\d{4}-\\d{2}-\\d{2}")) {
                return false;
            }
            
            // Extraer año
            String anioStr = fechaNacimiento.substring(0, 4);
            int anio = Integer.parseInt(anioStr);
            
            // Obtener año actual
            java.time.Year currentYear = java.time.Year.now();
            int anioActual = currentYear.getValue();
            
            // No debe ser futura y debe ser posterior a 1900
            return anio <= anioActual && anio >= 1900;
            
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * Calcula la edad actual basada en la fecha de nacimiento
     * @param fechaNacimiento Fecha de nacimiento como String (YYYY-MM-DD)
     * @return Edad en años
     */
    public static int calcularEdad(String fechaNacimiento) {
        if (fechaNacimiento == null) {
            return 0;
        }
        
        try {
            // Extraer año
            String anioStr = fechaNacimiento.substring(0, 4);
            int anioNacimiento = Integer.parseInt(anioStr);
            
            int anioActual = java.time.Year.now().getValue();
            return anioActual - anioNacimiento;
            
        } catch (Exception e) {
            return 0;
        }
    }
}
