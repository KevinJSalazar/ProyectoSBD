/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ec.edu.espol.petbackersbd;

import java.sql.CallableStatement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

/**
 *
 * @author levin
 */
public class CServicio {
    private int idSer;
    private int idCui;
    private int idTipoSer;
    private String titulo;
    private String descripción;
    private double precio;
    private String pais;
    private String provincia;
    private String ciudad;

    public int getIdSer() {
        return idSer;
    }

    public void setIdSer(int idSer) {
        this.idSer = idSer;
    }

    public int getIdCui() {
        return idCui;
    }

    public void setIdCui(int idCui) {
        this.idCui = idCui;
    }

    public int getIdTipoSer() {
        return idTipoSer;
    }

    public void setIdTipoSer(int idTipoSer) {
        this.idTipoSer = idTipoSer;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripción() {
        return descripción;
    }

    public void setDescripción(String descripción) {
        this.descripción = descripción;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }
    
    public void InsertarServicio(JTextField paramTitulo,JTextField paramDescripcion, JTextField paramPrecio, JTextField paramPais, JTextField paramProvincia, JTextField paramCiudad)
    {
        
        setTitulo(paramTitulo.getText());
        setDescripción(paramDescripcion.getText());
        setPrecio(Double.parseDouble(paramPrecio.getText()));
        setPais(paramPais.getText());
        setProvincia(paramProvincia.getText());
        setCiudad(paramCiudad.getText());
         
        Conexion objetoConexion = new CConexion();
        
        String consulta = "insert into Servicio (titulo, descripcion, precio, pais, provincia, ciudad) values (?,?,?,?,?,?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, getTitulo());
            cs.setString(2, getDescripción());
            cs.setDouble(3, getPrecio());
            cs.setString(4, getPais());
            cs.setString(5, getProvincia());
            cs.setString(6, getCiudad());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente el servicio");
            
        } catch (Exception e) {
            
            JOptionPane.showMessageDialog(null, "No se insertó correctamente el servicio, error: " + e.toString());
        }
        
    }
    
    
}
