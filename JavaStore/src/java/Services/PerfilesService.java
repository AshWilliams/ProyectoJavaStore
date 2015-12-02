/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Perfil;
import java.sql.Connection;
import org.json.simple.JSONArray;

/**
 *
 * @author Cypher
 */
public class PerfilesService {
    private Perfil myPerfil;

    public PerfilesService(Connection cnx) {
        this.myPerfil = new Perfil(cnx);
    }
    
    public JSONArray getAll(){          
        return myPerfil.getAll();        
    }
    
    public void insertPerfil(String Nombre,String Alias){
        myPerfil.insertPerfil(Nombre, Alias);
    }
    
    public void updatePerfil(String IdPerfil,String Nombre,String Alias){
        myPerfil.updatePerfil(IdPerfil, Nombre, Alias);
    }
    
    public void deletePerfil(String IdPerfil){
        myPerfil.deletePerfil(IdPerfil);
    }
}
