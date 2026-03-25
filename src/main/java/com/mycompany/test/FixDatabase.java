package com.mycompany.test;

import com.mycompany.conexion.ConexionDB;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

/**
 * Clase para ejecutar el script de corrección de la base de datos
 * @author Nelson Diaz
 */
public class FixDatabase {
    
    public static void main(String[] args) {
        System.out.println("=== CORRIGIENDO BASE DE DATOS ===");
        
        try {
            // Ejecutar el script SQL
            ejecutarScriptSQL("database_setup.sql");
            System.out.println("✅ Base de datos corregida exitosamente");
            
        } catch (Exception e) {
            System.err.println("❌ Error al corregir la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("=== PROCESO FINALIZADO ===");
    }
    
    private static void ejecutarScriptSQL(String archivoSQL) throws IOException, SQLException {
        System.out.println("Ejecutando script SQL: " + archivoSQL);
        
        try (Connection conn = ConexionDB.getConexion();
             Statement stmt = conn.createStatement();
             BufferedReader br = new BufferedReader(new FileReader(archivoSQL))) {
            
            StringBuilder sqlBuilder = new StringBuilder();
            String linea;
            
            while ((linea = br.readLine()) != null) {
                // Ignorar comentarios y líneas vacías
                if (linea.trim().isEmpty() || linea.trim().startsWith("--")) {
                    continue;
                }
                
                sqlBuilder.append(linea).append("\n");
                
                // Si la línea termina con ;, ejecutar la instrucción
                if (linea.trim().endsWith(";")) {
                    String sql = sqlBuilder.toString().trim();
                    if (!sql.isEmpty()) {
                        System.out.println("Ejecutando: " + sql.substring(0, Math.min(sql.length(), 50)) + "...");
                        stmt.execute(sql);
                    }
                    sqlBuilder.setLength(0); // Limpiar para la siguiente instrucción
                }
            }
        }
    }
}
