package com.mycompany.test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

/**
 * Prueba del endpoint de validación de ID
 */
public class TestEndpointValidacion {
    
    public static void main(String[] args) {
        System.out.println("=== PROBANDO ENDPOINT DE VALIDACIÓN ===");
        
        // Probar con ID que existe (123)
        probarEndpoint(123);
        
        // Probar con ID que no existe (999)
        probarEndpoint(999);
        
        System.out.println("=== PRUEBA DE ENDPOINT FINALIZADA ===");
    }
    
    private static void probarEndpoint(int id) {
        try {
            System.out.println("\nProbando ID: " + id);
            
            // Crear URL de prueba usando URI.toURL() (método moderno)
            String urlString = "http://localhost:8080/proyecto-usuarios/usuario?accion=validarID&id=" + id;
            URI uri = URI.create(urlString);
            URL url = uri.toURL();
            
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            int responseCode = conn.getResponseCode();
            System.out.println("Código de respuesta: " + responseCode);
            
            if (responseCode == 200) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();
                
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                
                String respuesta = response.toString().trim();
                System.out.println("Respuesta: '" + respuesta + "'");
                
                if (respuesta.equals("existe")) {
                    System.out.println("✅ El ID " + id + " existe");
                } else if (respuesta.equals("disponible")) {
                    System.out.println("✅ El ID " + id + " está disponible");
                } else {
                    System.out.println("❌ Respuesta inesperada: " + respuesta);
                }
            } else {
                System.out.println("❌ Error HTTP: " + responseCode);
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error al probar endpoint: " + e.getMessage());
            System.out.println("   Nota: El servidor debe estar corriendo en http://localhost:8080/proyecto-usuarios/");
        }
    }
}
