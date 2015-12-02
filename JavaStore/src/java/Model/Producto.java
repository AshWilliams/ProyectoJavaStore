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
public class Producto {
    private Connection cnx;
    JSONObject objProducto;

    public Producto(Connection cnx) {
        this.cnx = cnx;        
    }

    public Producto() {
    }
    
    public JSONArray getProductos(){
        String sql = "select \n" +
            "pr.IdProducto,pr.Nombre,pr.Especificaciones,\n" +
            "pr.Precio,pr.Stock,cate.idCategoria,cate.Nombre Categoria \n" +
            "from productos pr\n" +
            "inner join categorias cate\n" +
            "on(pr.IdCategoria = cate.idCategoria)";       
        JSONArray misProductos = new JSONArray();
        
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            try (ResultSet rs = stmt.executeQuery()){ 
                while (rs.next()) {
                    this.objProducto = new JSONObject();
                    objProducto.put("IdProducto",rs.getInt("IdProducto"));
                    objProducto.put("Nombre",rs.getString("Nombre"));
                    objProducto.put("Especificaciones",rs.getString("Especificaciones"));
                    objProducto.put("Precio",rs.getInt("Precio"));
                    objProducto.put("Stock",rs.getInt("Stock"));
                    objProducto.put("IdCategoria",rs.getInt("idCategoria"));
                    objProducto.put("Categoria",rs.getString("Categoria"));
                    misProductos.add(objProducto);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return misProductos;
    }
    
    public void deleteProducto(String IdProducto){
        String qry = "delete from Productos where IdProducto = ?";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, IdProducto);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateProducto(String IdProducto,String Nombre,String Especificacion,String Categoria,String Precio,String Stock){
        String qry = "update Productos set Nombre = ?,Especificaciones = ?,Precio = ?,Stock = ?, IdCategoria = ? where IdProducto = ?";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, Nombre);
            stmt.setString(2, Especificacion);
            stmt.setString(3,Precio);
            stmt.setString(4, Stock);
            stmt.setString(5, Categoria);
            stmt.setString(6, IdProducto);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    }
    
    public void insertProducto(String Nombre,String Especificacion,String Categoria,String Precio,String Stock){
        String qry = "insert into Productos(Nombre,Especificaciones,Precio,Stock,IdCategoria) values(?,?,?,?,?)";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, Nombre);
            stmt.setString(2, Especificacion);
            stmt.setString(3,Precio);
            stmt.setString(4, Stock);
            stmt.setString(5, Categoria);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    }
    
}
