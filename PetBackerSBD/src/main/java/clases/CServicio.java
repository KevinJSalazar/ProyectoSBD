/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clases.CConexion;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

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
    
    public void InsertarServicio(JTextField paramidCui, JTextField paramTitulo,JTextField paramDescripcion, JTextField paramPrecio, JTextField paramPais, JTextField paramProvincia, JTextField paramCiudad, JTextField paramidTipser)
    {
        
        setIdCui(Integer.parseInt(paramidCui.getText()));
        setTitulo(paramTitulo.getText());
        setDescripción(paramDescripcion.getText());
        setPrecio(Double.parseDouble(paramPrecio.getText()));
        setPais(paramPais.getText());
        setProvincia(paramProvincia.getText());
        setCiudad(paramCiudad.getText());
        setIdTipoSer(Integer.parseInt(paramidTipser.getText())); 
        
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call InsertarServicio(?,?,?,?,?,?,?,?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, getIdCui());
            cs.setString(2, getTitulo());
            cs.setString(3, getDescripción());
            cs.setDouble(4, getPrecio());
            cs.setString(5, getPais());
            cs.setString(6, getProvincia());
            cs.setString(7, getCiudad());
            cs.setInt(8, getIdTipoSer());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente el servicio");
            
        } catch (Exception e) {
            
            JOptionPane.showMessageDialog(null, "No se insertó correctamente el servicio, error: " + e.toString());
        }
        
    }
    
        public void mostrarServicio(JTable paramTbl)
        {
            CConexion objetoConexion = new CConexion();
            
            DefaultTableModel modelo = new DefaultTableModel();
            
            TableRowSorter<TableModel> ordenarTabla = new TableRowSorter<TableModel>(modelo);
            paramTbl.setRowSorter(ordenarTabla);
            
            String sql = "";
            
            modelo.addColumn("idServicio");
            modelo.addColumn("idCuidador");
            modelo.addColumn("Titulo");
            modelo.addColumn("Descripción");
            modelo.addColumn("Precio");
            modelo.addColumn("País");
            modelo.addColumn("Provincia");
            modelo.addColumn("Ciudad");
            modelo.addColumn("idTipoServicio");
            
            paramTbl.setModel(modelo);
            
            sql = "select * from Servicio;";
            
            String[] datos = new String[9];
            Statement st;
            
            try {
                
                st = objetoConexion.estableceConexion().createStatement();
                
                ResultSet rs = st.executeQuery(sql);
                
                while(rs.next())
                {
                    datos[0] = rs.getString(1);
                    datos[1] = rs.getString(2);
                    datos[2] = rs.getString(3);
                    datos[3] = rs.getString(4);
                    datos[4] = rs.getString(5);
                    datos[5] = rs.getString(6);
                    datos[6] = rs.getString(7);
                    datos[7] = rs.getString(8);
                    datos[8] = rs.getString(9);
                    
                    modelo.addRow(datos);
                }
                
                paramTbl.setModel(modelo);
                
            } catch (Exception e) {
                
                JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
            }
            
        }
    
       public void seleccionarServicio(JTable paramTablaServicio,JTextField paramidSer, JTextField paramidCui, JTextField paramidTipoSer, JTextField paramTitulo,JTextField paramDescripcion, JTextField paramPrecio, JTextField paramPais, JTextField paramProvincia, JTextField paramCiudad)
    {
        try {
            int fila = paramTablaServicio.getSelectedRow();
            
            if(fila >= 0)
            {
                paramidSer.setText(paramTablaServicio.getValueAt(fila, 0).toString());
                paramidCui.setText(paramTablaServicio.getValueAt(fila, 1).toString());
                paramidTipoSer.setText(paramTablaServicio.getValueAt(fila, 8).toString());
                paramTitulo.setText(paramTablaServicio.getValueAt(fila, 2).toString());
                paramDescripcion.setText(paramTablaServicio.getValueAt(fila, 3).toString());
                paramPrecio.setText(paramTablaServicio.getValueAt(fila, 4).toString());
                paramPais.setText(paramTablaServicio.getValueAt(fila, 5).toString());
                paramProvincia.setText(paramTablaServicio.getValueAt(fila, 6).toString());
                paramCiudad.setText(paramTablaServicio.getValueAt(fila, 7).toString());
            }
            
            else
            {
                JOptionPane.showMessageDialog(null, "Fila no seleccionada");
            }
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error de seleccion, error: " + e.toString());
        }
    }
    
    public void modificarServicio(JTextField paramIdSer, JTextField paramIdCui, JTextField paramTitulo,JTextField paramDescripcion, JTextField paramPrecio, JTextField paramPais, JTextField paramProvincia, JTextField paramCiudad, JTextField paramIdTipser)
    {

        setIdSer(Integer.parseInt(paramIdSer.getText()));
        setIdCui(Integer.parseInt(paramIdCui.getText()));
        setTitulo(paramTitulo.getText());
        setDescripción(paramDescripcion.getText());
        setPrecio(Double.parseDouble(paramPrecio.getText()));
        setPais(paramPais.getText());
        setProvincia(paramProvincia.getText());
        setCiudad(paramCiudad.getText());
        setIdTipoSer(Integer.parseInt(paramIdTipser.getText())); 
 
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call ActualizarServicio(?,?,?,?,?,?,?,?,?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            
            cs.setInt(1, getIdSer());
            cs.setInt(2, getIdCui());
            cs.setString(3,getTitulo());
            cs.setString(4, getDescripción());
            cs.setDouble(5, getPrecio());
            cs.setString(6, getPais());
            cs.setString(7, getProvincia());
            cs.setString(8, getCiudad());
            cs.setInt(9, getIdTipoSer());

            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Modificación exitosa");
            
        } catch (SQLException e) {
            
            JOptionPane.showMessageDialog(null, "No se pudo modificar, error: " + e.toString());
            
        }
    }
    
    public void eliminarServicio(JTextField paramidSer)
    {
        setIdSer(Integer.parseInt(paramidSer.getText()));
        
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call EliminarServicio(?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, getIdSer());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Eliminado para siempre");
            
        } catch (SQLException e) {
            
            JOptionPane.showMessageDialog(null, "No se pudo eliminar, error: " + e.toString());
            
        }
    }
    
}
