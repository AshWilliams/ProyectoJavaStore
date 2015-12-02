/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Cypher
 */
public class Graficos {
    private JSONObject objGraph;
    private Connection cnx;

    public Graficos(Connection cnx) {
        this.cnx = cnx;
    }
    
    public JSONArray getAll(){          
        String sql = "select Nombre,Stock from Productos";
        JSONArray misGraficos = new JSONArray();
        
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            try (ResultSet rs = stmt.executeQuery()){ 
                while (rs.next()) {
                    this.objGraph = new JSONObject();
                    objGraph.put("Nombre",rs.getString("Nombre"));
                    objGraph.put("Stock", rs.getString("Stock"));
                    misGraficos.add(objGraph);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return misGraficos;       
    }
    
}
