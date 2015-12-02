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
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Cypher
 */
public class Perfil {
    private Connection cnx;
    private JSONObject objPerfil;
    public Perfil(Connection cnx) {
        this.cnx = cnx;
    }
    public JSONArray getAll(){          
        String sql = "select * from Perfiles";
        JSONArray misPerfiles = new JSONArray();
        
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            try (ResultSet rs = stmt.executeQuery()){ 
                while (rs.next()) {
                    this.objPerfil = new JSONObject();
                    objPerfil.put("idPerfil",rs.getString("idPerfil"));
                    objPerfil.put("Nombre",rs.getString("Nombre"));
                    objPerfil.put("Alias",rs.getString("Alias"));
                    objPerfil.put("Fecha",rs.getDate("FechaCreacion", null).toString());
                    misPerfiles.add(objPerfil);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return misPerfiles;       
    }
    
    public void insertPerfil(String Nombre,String Alias){
        String qry = "insert into Perfiles(Nombre,Alias) values(?,?)";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, Nombre);
            stmt.setString(2, Alias);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updatePerfil(String IdPerfil,String Nombre,String Alias){
        String qry = "update Perfiles set Nombre = ?,Alias = ? where idPerfil = ?";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, Nombre);
            stmt.setString(2, Alias);
            stmt.setString(3, IdPerfil);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deletePerfil(String IdPerfil){
        String qry = "delete from Perfiles where idPerfil = ?";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, IdPerfil);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
