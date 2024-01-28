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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class CDonación {
    private int idDon;
    private int idRef;
    private int idUsu;
    private java.sql.Date fecha;
    private double monto;
    private double cupon;

    public int getIdDon() {
        return idDon;
    }

    public void setIdDon(int idDon) {
        this.idDon = idDon;
    }

    public int getIdRef() {
        return idRef;
    }

    public void setIdRef(int idRef) {
        this.idRef = idRef;
    }

    public int getIdUsu() {
        return idUsu;
    }

    public void setIdUsu(int idUsu) {
        this.idUsu = idUsu;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(java.sql.Date fecha) {
        this.fecha = fecha;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public double getCupon() {
        return cupon;
    }

    public void setCupon(double cupon) {
        this.cupon = cupon;
    }
    
    public void InsertarDonacion( JTextField paramidRef, JTextField paramidUser, JTextField paramFecha, JTextField paramMonto)
    {
        
        
      
        try {
            setFecha(java.sql.Date.valueOf(paramFecha.getText()));
            //setFecha( new SimpleDateFormat("YYYY-MM-dd", Locale.ENGLISH).parse(paramFecha.getText()));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        setIdRef(Integer.parseInt(paramidRef.getText()));
        setIdUsu(Integer.parseInt(paramidUser.getText()));
        setMonto(Double.parseDouble(paramMonto.getText()));
        
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call InsertarDonacion(?,?,?,?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, getIdRef());
            cs.setInt(2, getIdUsu());
            cs.setDate(3, (java.sql.Date) getFecha());
            cs.setDouble(4, getMonto());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente la donación");
            
        } catch (Exception e) {
            
            JOptionPane.showMessageDialog(null, "No se insertó correctamente la donación, error: " + e.toString());
        }

    }
    
    public void mostrarDonacion(JTable paramTbl)
        {
            CConexion objetoConexion = new CConexion();
            
            DefaultTableModel modelo = new DefaultTableModel();
            
            TableRowSorter<TableModel> ordenarTabla = new TableRowSorter<TableModel>(modelo);
            paramTbl.setRowSorter(ordenarTabla);
            
            String sql = "";
            
            modelo.addColumn("idDonación");
            modelo.addColumn("idRefugio");
            modelo.addColumn("idUsuario");
            modelo.addColumn("Fecha");
            modelo.addColumn("Monto");
            modelo.addColumn("Cupon");
            
            paramTbl.setModel(modelo);
            
            sql = "select * from Donacion;";
            
            String[] datos = new String[6];
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
                    
                    modelo.addRow(datos);
                }
                
                paramTbl.setModel(modelo);
                
            } catch (Exception e) {
                
                JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
            }
            
        }
    
    public void seleccionarDonación(JTable paramTablaDonacion, JTextField paramidDon, JTextField paramidRef, JTextField paramidUsu, JTextField paramFecha,JTextField paramMonto, JTextField paramCupon )
    {
        try {
            int fila = paramTablaDonacion.getSelectedRow();
            
            if(fila >= 0)
            {
                paramidDon.setText(paramTablaDonacion.getValueAt(fila, 0).toString());
                paramidRef.setText(paramTablaDonacion.getValueAt(fila, 1).toString());
                paramidUsu.setText(paramTablaDonacion.getValueAt(fila, 2).toString());
                paramFecha.setText(paramTablaDonacion.getValueAt(fila, 3).toString());
                paramMonto.setText(paramTablaDonacion.getValueAt(fila, 4).toString());
                paramCupon.setText(paramTablaDonacion.getValueAt(fila, 5).toString());
            }
            
            else
            {
                JOptionPane.showMessageDialog(null, "Fila no seleccionada");
            }
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error de seleccion, error: " + e.toString());
        }
    }
    
    public void modificarDonación(JTextField paramId, JTextField paramIdRef, JTextField paramIdUser, JTextField paramFecha, JTextField paramMonto)
    {
        try {
            
            setFecha(java.sql.Date.valueOf(paramFecha.getText()));
            //setFecha(new SimpleDateFormat("YYYY-MM-dd", Locale.ENGLISH).parse(paramFecha.getText()));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        setIdRef(Integer.parseInt(paramIdRef.getText()));
        setIdUsu(Integer.parseInt(paramIdUser.getText()));
        setMonto(Double.parseDouble(paramMonto.getText()));
        
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call ActualizarDonacion(?,?,?,?,?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.setInt(2, getIdRef());
            cs.setInt(3, getIdUsu());
            cs.setDate(4, (java.sql.Date) getFecha());
            cs.setDouble(5, getMonto());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Modificación exitosa");
            
        } catch (SQLException e) {
            
            JOptionPane.showMessageDialog(null, "No se pudo modificar, error: " + e.toString());
            
        }
    }
    
    public void eliminarDonacion(JTextField paramidDon)
    {
        setIdDon(Integer.parseInt(paramidDon.getText()));
        
        CConexion objetoConexion = new CConexion();
        
        String consulta = "call EliminarDonacion(?);";
        
        try {
            
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, getIdDon());
            
            cs.execute();
            
            JOptionPane.showMessageDialog(null, "Eliminado para siempre");
            
        } catch (SQLException e) {
            
            JOptionPane.showMessageDialog(null, "No se pudo eliminar, error: " + e.toString());
            
        }
    }
    
}
