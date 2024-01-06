/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.swing.JOptionPane;

/**
 *
 * @author evin
 */
public class CConexion {
    Connection conectar = null;
    
    String usuario = "root";
    String contraseña = "root";
    String bd = "PetBacker";
    String ip = "127.0.0.1";
    String puerto = "3306";
    
    String cadena = "jdbc:mysql://"+ip+":"+puerto+"/"+bd;
    
    public Connection estableceConexion(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conectar = DriverManager.getConnection(cadena, usuario, contraseña);
        } catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error al conectarse con la base de datos, error: " + e.toString());
        }
        return conectar;
    }
}
