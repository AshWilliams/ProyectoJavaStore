/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Model.Graficos;
import java.sql.Connection;
import org.json.simple.JSONArray;

/**
 *
 * @author Cypher
 */
public class DashBoardService {
    private Graficos myGrafico;

    public DashBoardService(Connection cnx) {
        this.myGrafico = new Graficos(cnx);
    }
    
    public JSONArray getStock(){
        return myGrafico.getAll();
    }
}
