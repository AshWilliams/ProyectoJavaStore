/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Categoria;
import java.sql.Connection;
import java.util.ArrayList;
import org.json.simple.JSONArray;

/**
 *
 * @author Overlord
 */
public class CategoriaServices {
    private Categoria myCategoria;
    public CategoriaServices(Connection cnx){
        myCategoria = new Categoria(cnx);
    }
    
    public JSONArray getCategorias(){          
        return myCategoria.getCategorias();        
    }
}
