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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Formatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cypher
 */
public class Usuario {
    private String attrUsuario;
    private String attrNombres;
    private String attrApellidos;
    private String attrMail;
    private Connection cnx;
    public Usuario(Connection cnx) {
        this.cnx = cnx;
    }

    
    public Usuario(String attrUsuario, String attrNombres, String attrApellidos, String attrMail) {
        this.attrUsuario = attrUsuario;
        this.attrNombres = attrNombres;
        this.attrApellidos = attrApellidos;
        this.attrMail = attrMail;
    }

    public int validaUsuario(String usuario,String password,HttpServletRequest request){
       String sql = "select count(1),concat(Nombres,' ',Apellidos) from Usuarios where Usuario=? and Pass=?";
       String sha1 = "";
       int conteo = 0;
       MessageDigest crypt;
       HttpSession objSesion = request.getSession(true);
        try {
            crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
           try {
               crypt.update(password.getBytes("UTF-8"));
           } catch (UnsupportedEncodingException ex) {
               Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
           }
            sha1 = byteToHex(crypt.digest());
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            
            stmt.setString(1, usuario);
            stmt.setString(2, sha1);
            try (ResultSet rs = stmt.executeQuery()){ 
                if (rs.next()) {
                    conteo = rs.getInt(1); 
                    objSesion.setAttribute("Usuario", rs.getString(2));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return conteo;
    }
    
    private static String byteToHex(final byte[] hash)
    {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
    
    public String getAttrUsuario() {
        return attrUsuario;
    }

    public void setAttrUsuario(String attrUsuario) {
        this.attrUsuario = attrUsuario;
    }    

    public String getAttrNombres() {
        return attrNombres;
    }

    public void setAttrNombres(String attrNombres) {
        this.attrNombres = attrNombres;
    }

    public String getAttrApellidos() {
        return attrApellidos;
    }

    public void setAttrApellidos(String attrApellidos) {
        this.attrApellidos = attrApellidos;
    }

    public String getAttrMail() {
        return attrMail;
    }

    public void setAttrMail(String attrMail) {
        this.attrMail = attrMail;
    }
    
    
    
}
