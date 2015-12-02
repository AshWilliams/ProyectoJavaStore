/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;


import Services.UsuarioServices;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Cypher
 */
public class Usuarios extends HttpServlet {
    @Resource(mappedName = "jdbc/MySQLConn")
    private DataSource ds;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String metodo = request.getMethod();
        HttpSession objSesion = request.getSession(true); 
        if(objSesion.getAttribute("ValidUser") != null){
            if(metodo.equals("GET") && (boolean)objSesion.getAttribute("ValidUser")){
                request.getRequestDispatcher("Views/CRUDUsuarios.jsp").forward(request, response);
            } 
            
            if(metodo.equals("POST") && (boolean)objSesion.getAttribute("ValidUser")){
                JSONObject json = new JSONObject();
                JSONArray misUsuarios = new JSONArray();
                String method = request.getParameter("Metodo");
                
                if(method.equals("listall")){
                    try(Connection cnx = ds.getConnection()){
                        UsuarioServices userService = new UsuarioServices(cnx);                 
                        misUsuarios = userService.getAll();
                    }catch (SQLException e) {
                        json.put("Mensaje",e.getMessage());
                    }
                    try (PrintWriter out = response.getWriter()) {
                        /* TODO output your page here. You may use following sample code. */
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(misUsuarios.toJSONString()); 
                    }
                }
                
                if(method.equals("insert")){
                    try(Connection cnx = ds.getConnection()){
                        String IdPerfil = request.getParameter("IdPerfil");
                        String Usuario = request.getParameter("Usuario");
                        String Password = request.getParameter("Password");
                        String Nombres = request.getParameter("Nombres");
                        String Apellidos = request.getParameter("Apellidos");
                        String Rut = request.getParameter("Rut");
                        String Direccion = request.getParameter("Direccion");
                        String Email = request.getParameter("Email");
                        
                        UsuarioServices userService = new UsuarioServices(cnx);
                        userService.insertUsuario(IdPerfil, Usuario, Password, Nombres, Apellidos, Direccion, Email,Rut);
                        
                        json.put("Mensaje","Se ha insertado Usuario Correctamente");
                    }catch (SQLException e) {
                        json.put("Mensaje",e.getMessage());
                    }
                    try (PrintWriter out = response.getWriter()) {
                        /* TODO output your page here. You may use following sample code. */
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(json.toString());
                    }
                }
                if(method.equals("update")){
                    try(Connection cnx = ds.getConnection()){   
                        String IdUsuario = request.getParameter("IdUsuario");
                        String IdPerfil = request.getParameter("IdPerfil");
                        String Usuario = request.getParameter("Usuario");
                        String Password = request.getParameter("Password");
                        String Nombres = request.getParameter("Nombres");
                        String Rut = request.getParameter("Rut");
                        String Apellidos = request.getParameter("Apellidos");
                        String Direccion = request.getParameter("Direccion");
                        String Email = request.getParameter("Email");
                        
                        UsuarioServices userService = new UsuarioServices(cnx); 
                        userService.updateUsuario(IdUsuario, IdPerfil, Usuario, Password, Nombres, Apellidos, Direccion, Email,Rut);
                        json.put("Mensaje","Se ha Actualizado Usuario " + IdUsuario);
                    }catch (SQLException e) {
                        json.put("Mensaje",e.getMessage());
                    }
                    try (PrintWriter out = response.getWriter()) {
                        /* TODO output your page here. You may use following sample code. */
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(json.toString());
                    }
                }
                
                if(method.equals("delete")){
                    try(Connection cnx = ds.getConnection()){   
                        String IdUsuario = request.getParameter("IdUsuario");                        
                        UsuarioServices userService = new UsuarioServices(cnx); 
                        userService.deleteUser(IdUsuario);
                        json.put("Mensaje","Se ha Eliminado Usuario " + IdUsuario);
                    }catch (SQLException e) {
                        json.put("Mensaje",e.getMessage());
                    }
                    try (PrintWriter out = response.getWriter()) {
                        /* TODO output your page here. You may use following sample code. */
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(json.toString());
                    }
                }
            } 
                       
            
        }
        else{
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
