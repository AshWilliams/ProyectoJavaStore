/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Overlord
 */
public class Categoria {
    private int idCategoria;
    private String Nombre;
    private String Descripcion;
    private Date Fecha;
    private Connection cnx;

    public Categoria(Connection cnx) {
        this.cnx = cnx;
    }

    public Categoria(int idCategoria, String Nombre, String Descripcion, Date Fecha) {
        this.idCategoria = idCategoria;
        this.Nombre = Nombre;
        this.Descripcion = Descripcion;
        this.Fecha = Fecha;
    }

    public Categoria() {
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public Date getFecha() {
        return Fecha;
    }

    public void setFecha(Date Fecha) {
        this.Fecha = Fecha;
    }
    
    
    public JSONArray getCategorias(){
        String sql = "select * from Categorias";       
        JSONArray misCategorias = new JSONArray();
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            try (ResultSet rs = stmt.executeQuery()){ 
                while (rs.next()) {
                    JSONObject objCategoria = new JSONObject();  
                    objCategoria.put("IdCategoria",rs.getInt("idCategoria"));
                    objCategoria.put("Nombre",rs.getString("Nombre"));
                    objCategoria.put("Descripcion",rs.getString("Descripcion"));
                    objCategoria.put("Fecha",rs.getDate("FechaCreacion", null).toString());
                    misCategorias.add(objCategoria);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return misCategorias;
    }
    
    
}
