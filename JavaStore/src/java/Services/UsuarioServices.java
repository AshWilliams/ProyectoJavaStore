/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Usuario;
import java.sql.Connection;

/**
 *
 * @author Cypher
 */
public class UsuarioServices {
    private Usuario myUser;
    public UsuarioServices(Connection cnx) {
        myUser = new Usuario(cnx);
    }
    
    
    public int validaUsuario(String usuario,String password){
          
        return myUser.validaUsuario(usuario, password);
    }
    
}