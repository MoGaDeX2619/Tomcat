package com.mycompany.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de conexión a la base de datos MySQL
 * @author Nelson Diaz
 */
public class ConexionDB {
    
    // Datos de conexión
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/nelson_prueba?useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String CONTRASENA = "mogadex123";
    
    /**
     * Obtiene una conexión a la base de datos
     * @return Connection objeto de conexión
     * @throws SQLException si hay un error de conexión
     */
    public static Connection getConexion() throws SQLException {
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establecer la conexión
            Connection conexion = DriverManager.getConnection(URL, USUARIO, CONTRASENA);
            
            System.out.println("Conexión establecida exitosamente a la base de datos");
            return conexion;
            
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver de MySQL no encontrado - " + e.getMessage());
            throw new SQLException("Driver de MySQL no encontrado", e);
        } catch (SQLException e) {
            System.err.println("Error de conexión a la base de datos: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Cierra una conexión a la base de datos
     * @param conexion conexión a cerrar
     */
    public static void cerrarConexion(Connection conexion) {
        if (conexion != null) {
            try {
                conexion.close();
                System.out.println("Conexión cerrada exitosamente");
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}
