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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
    private JSONObject objUsuario;
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
       String sql = "select count(1),concat(USR.Nombres,' ',USR.Apellidos),PER.Nombre ";
       sql +="from Usuarios USR inner join Perfiles PER on(USR.idPerfil = PER.idPerfil) ";
       sql +="where USR.Usuario=? and USR.Pass=?";
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
                    objSesion.setAttribute("Perfil", rs.getString(3));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return conteo;
    }
    
    public JSONArray getAll(){
        String sql = "select USR.idUsuario,USR.Usuario,USR.Nombres,USR.Apellidos,concat(USR.Nombres,' ',USR.Apellidos) Completo,USR.Rut,USR.Email,USR.Direccion,";
        sql +="PER.idPerfil,PER.Nombre from Usuarios USR";
        sql += " inner join Perfiles PER on(USR.idPerfil = PER.idPerfil)";
        JSONArray misUsuarios = new JSONArray();
        
        try (PreparedStatement stmt = cnx.prepareStatement(sql)){
            try (ResultSet rs = stmt.executeQuery()){ 
                while (rs.next()) {
                    this.objUsuario = new JSONObject();
                    objUsuario.put("idUsuario",rs.getString("idUsuario"));
                    objUsuario.put("Usuario",rs.getString("Usuario"));
                    objUsuario.put("Completo",rs.getString("Completo"));
                    objUsuario.put("Nombres",rs.getString("Nombres"));
                    objUsuario.put("Apellidos",rs.getString("Apellidos"));
                    objUsuario.put("Rut",rs.getString("Rut"));
                    objUsuario.put("Email",rs.getString("Email"));
                    objUsuario.put("Direccion",rs.getString("Direccion"));
                    objUsuario.put("idPerfil",rs.getString("idPerfil"));
                    objUsuario.put("Perfil",rs.getString("Nombre"));
                    misUsuarios.add(objUsuario);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por registro ", e);
        }   
        return misUsuarios;
    }
    
    public void updateUsuario(String IdUsuario,String IdPerfil,String Usuario,String Password,String Nombres,String Apellidos,String Direccion,String Email,String Rut){
        String qry = "update usuarios set idPerfil=?,Usuario=?,Pass=?,Nombres=?,Apellidos=?,Direccion=?,Email=?,Rut=? where idUsuario = ?";
        String sha1 = "";
        int conteo = 0;
        MessageDigest crypt;
         try {
             crypt = MessageDigest.getInstance("SHA-1");
             crypt.reset();
            try {
                crypt.update(Password.getBytes("UTF-8"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            }
             sha1 = byteToHex(crypt.digest());
         } catch (NoSuchAlgorithmException ex) {
             Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
         }
        
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, IdPerfil);
            stmt.setString(2, Usuario);
            stmt.setString(3, sha1);
            stmt.setString(4, Nombres);
            stmt.setString(5, Apellidos);
            stmt.setString(6, Direccion);
            stmt.setString(7, Email);
            stmt.setString(8, Rut);
            stmt.setString(9, IdUsuario);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void insertUsuario(String IdPerfil,String Usuario,String Password,String Nombres,String Apellidos,String Direccion,String Email,String Rut){
        String qry = "insert into usuarios(idPerfil,Usuario,Pass,Nombres,Apellidos,Direccion,Email,Rut) values(?,?,?,?,?,?,?,?)";
        String sha1 = "";
        int conteo = 0;
        MessageDigest crypt;
         try {
             crypt = MessageDigest.getInstance("SHA-1");
             crypt.reset();
            try {
                crypt.update(Password.getBytes("UTF-8"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            }
             sha1 = byteToHex(crypt.digest());
         } catch (NoSuchAlgorithmException ex) {
             Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
         }
        
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, IdPerfil);
            stmt.setString(2, Usuario);
            stmt.setString(3, sha1);
            stmt.setString(4, Nombres);
            stmt.setString(5, Apellidos);
            stmt.setString(6, Direccion);
            stmt.setString(7, Email);
            stmt.setString(8, Rut);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteUsuario(String IdUsuario){
        String qry = "delete from Usuarios where idUsuario = ?";
        try (PreparedStatement stmt = cnx.prepareStatement(qry)){
            stmt.setString(1, IdUsuario);
            stmt.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
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
