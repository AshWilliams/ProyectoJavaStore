/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Services.DashBoardService;
import Services.PerfilesService;
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
public class DashBoard extends HttpServlet {
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
                request.getRequestDispatcher("Views/DashBoard.jsp").forward(request, response);
            } 
        }
        if(metodo.equals("POST") && (boolean)objSesion.getAttribute("ValidUser")){
                JSONObject json = new JSONObject();
                JSONArray misGraficos = new JSONArray();
                String method = request.getParameter("Metodo");

                if(method.equals("getStock")){
                    try(Connection cnx = ds.getConnection()){
                        DashBoardService myDash = new DashBoardService(cnx);
                        misGraficos = myDash.getStock();
                    }catch (SQLException e) {
                        json.put("Mensaje",e.getMessage());
                    }
                    try (PrintWriter out = response.getWriter()) {
                        /* TODO output your page here. You may use following sample code. */
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(misGraficos.toJSONString()); 
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
