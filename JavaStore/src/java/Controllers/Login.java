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
public class Login extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            //create Json Object
            String metodo = request.getMethod();
            
            if(metodo.equals("POST")){
                JSONObject json = new JSONObject();
                //JSONArray jsonAraay = new JSONArray(your_array_list);
                String usuario = request.getParameter("inputUsuario");
                String password = request.getParameter("inputPassword");
                try(Connection cnx = ds.getConnection()){
                    UsuarioServices userService = new UsuarioServices(cnx);
                    int respuesta = userService.validaUsuario(usuario, password);
                    HttpSession objSesion = request.getSession(true); 
                    if(respuesta == 1){                        
                        objSesion.setAttribute("ValidUser",  true);                        
                        json.put("Codigo",200);
                        json.put("Estado", respuesta);
                        json.put("Mensaje","Usuario Logueado Correctamente....Redirigiendo");
                    }
                    else{
                        json.put("Codigo",500);
                        json.put("Estado", respuesta);
                        json.put("Mensaje","Esta cuenta no existe. Indica una cuenta diferente ");
                    }

                    //json.put("Url", request.getRequestURI());
                    // finally output the json string       
                    out.print(json.toString()); 
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                
                
            }
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
