/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ec.edu.espol.petbackersbd;

import java.sql.CallableStatement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    private Date fecha;
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

    public void setFecha(Date fecha) {
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
    
    public void InsertarDonacion(JTextField paramFecha,JTextField paramMonto, JTextField paramCupon)
    {
//        try {
//            setFecha(new SimpleDateFormat("YYYY-MM-dd", Locale.ENGLISH).parse(paramFecha.getText()));
//        } catch (ParseException ex) {
//            ex.printStackTrace();
//        }
//        
//        setMonto(Double.parseDouble(paramMonto.getText()));
//        setCupon(Double.parseDouble(paramCupon.getText()));
//        
//        Conexion objetoConexion = new CConexion();
//        
//        String consulta = "insert into Donacion (fecha,monto,cupon) values (?,?,?);";
//        
//        try {
//            
//            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
//            cs.setDate(1, (java.sql.Date) getFecha());
//            cs.setDouble(2, getMonto());
//            cs.setDouble(3, getCupon());
//            
//            cs.execute();
//            
//            JOptionPane.showMessageDialog(null, "Se insertó correctamente la donación");
//            
//        } catch (Exception e) {
//            
//            JOptionPane.showMessageDialog(null, "No se insertó correctamente la donación, error: " + e.toString());
//        }

    }
    
    public void mostrarDonacion(JTable paramTbl)
        {
//            CConexion objetoConexion = new CConexion();
//            
//            DefaultTableModel modelo = new DefaultTableModel();
//            
//            TableRowSorter<TableModel> ordenarTabla = new TableRowSorter<TableModel>(modelo);
//            paramTbl.setRowSorter(ordenarTabla);
//            
//            String sql = "";
//            
//            modelo.addColumn("id");
//            modelo.addColumn();
        }
    
}
