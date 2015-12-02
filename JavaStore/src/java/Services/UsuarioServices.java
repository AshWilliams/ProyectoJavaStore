/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Usuario;
import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import org.json.simple.JSONArray;

/**
 *
 * @author Cypher
 */
public class UsuarioServices {
    private Usuario myUser;
    public UsuarioServices(Connection cnx) {
        myUser = new Usuario(cnx);
    }
    
    
    public int validaUsuario(String usuario,String password,HttpServletRequest request){
          
        return myUser.validaUsuario(usuario, password, request);
    }
    
    public JSONArray getAll(){          
        return myUser.getAll();        
    }
    
    public void insertUsuario(String IdPerfil,String Usuario,String Password,String Nombres,String Apellidos,String Direccion,String Email,String Rut){
        myUser.insertUsuario(IdPerfil, Usuario, Password, Nombres, Apellidos, Direccion, Email,Rut);
    }
    
    public void updateUsuario(String IdUsuario,String IdPerfil,String Usuario,String Password,String Nombres,String Apellidos,String Direccion,String Email,String Rut){
        myUser.updateUsuario(IdUsuario, IdPerfil, Usuario, Password, Nombres, Apellidos, Direccion, Email,Rut);
    }
    
    public void deleteUser(String IdUsuario){          
       myUser.deleteUsuario(IdUsuario);
    }
    
}
