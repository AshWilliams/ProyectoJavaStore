/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Categoria;
import Model.Producto;
import java.sql.Connection;
import org.json.simple.JSONArray;

/**
 *
 * @author Cypher
 */
public class ProductosService {
    private Producto myProducto;
    public ProductosService(Connection cnx){
        myProducto = new Producto(cnx);
    }
    
    public JSONArray getProductos(){          
        return myProducto.getProductos();        
    }
    
    public void deleteProducto(String IdProducto){
        myProducto.deleteProducto(IdProducto);
    }
    
    public void updateProducto(String IdProducto,String Nombre,String Especificacion,String Categoria,String Precio,String Stock){
        myProducto.updateProducto(IdProducto, Nombre, Especificacion, Categoria, Precio, Stock);
    }
    
    public void insertProducto(String Nombre,String Especificacion,String Categoria,String Precio,String Stock){
        myProducto.insertProducto(Nombre, Especificacion, Categoria, Precio, Stock);
    }
}
