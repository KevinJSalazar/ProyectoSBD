/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import com.toedter.calendar.JDateChooser;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

/**
 *
 * @author Alejandro Diez
 */
public class CTipoAseo {
    int id;
    int idTipo_ser;
    String tipo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdTipo_ser() {
        return idTipo_ser;
    }

    public void setIdTipo_ser(int idTipo_ser) {
        this.idTipo_ser = idTipo_ser;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public void saveTipoAseo(JTextField paramidtipserv, JComboBox paramtipo){
        
        setIdTipo_ser(Integer.parseInt(paramidtipserv.getText()));
        setTipo(paramtipo.getSelectedItem().toString());
        
        CConexion objetoconexion = new CConexion();
        
        String consulta="call InsertarTipoAseo(?,?);";
        
        try{
            CallableStatement es = objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setInt(1, getIdTipo_ser());
            es.setString(2, getTipo());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente el tipo de aseo");
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, "No se insertó correctamente el tipo de aseo, el Error:"+e.toString());
        }
    }
    
    public void showTipoAseo(JTable paramTablaTotalTipoAseo){
        
        CConexion Objetoconexion = new CConexion();
        
        DefaultTableModel model = new DefaultTableModel();
        
        TableRowSorter<TableModel> OrdenarTabla = new TableRowSorter<TableModel>(model);
    
        String sql="";
        
        model.addColumn("id");
        model.addColumn("idTipoAseo");
        model.addColumn("Aseo");
        
        paramTablaTotalTipoAseo.setModel(model);
        
        sql = "Select * from TipoAseo;";
        
        String[] datos = new String[3];
        Statement st;
        
        try{
            st= Objetoconexion.estableceConexion().createStatement();
            
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                datos[0]= rs.getString(1);
                datos[1]= rs.getString(2);
                datos[2]= rs.getString(3);
                
                model.addRow(datos);
                
            }
            
            paramTablaTotalTipoAseo.setModel(model);
        }
        catch(Exception e){
            
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, el error:"+e.toString());
        }
    }
    
    public void selectTipoAseo(JTable paramTablaTotalTipoAseo, JTextField paramid, JTextField paramidtipserv, JComboBox paramtipo){
        
        try{
            int fila = paramTablaTotalTipoAseo.getSelectedRow();
            
            if(fila >= 0){
                
                paramid.setText(paramTablaTotalTipoAseo.getValueAt(fila, 0).toString());
                paramidtipserv.setText(paramTablaTotalTipoAseo.getValueAt(fila, 1).toString());
                paramtipo.setSelectedItem(paramTablaTotalTipoAseo.getValueAt(fila, 2).toString());
            }
            else
                JOptionPane.showMessageDialog(null, "Fila no seleccionada");
        
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error de selección, el error:"+e.toString());
        }
    }
    
        public void modifyTipoAseo(JTextField paramid, JTextField paramidtipserv, JComboBox paramtipo){
        setId(Integer.parseInt(paramid.getText()));
        setIdTipo_ser(Integer.parseInt(paramidtipserv.getText()));
        setTipo(paramtipo.getSelectedItem().toString());
        
        CConexion Objetoconexion = new CConexion();
        
        String consulta="call ActualizarTipoAseo(?,?,?);";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setInt(1, getId());
            es.setInt(2, getIdTipo_ser());
            es.setString(3, getTipo());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se modificó correctamente el tipo de Aseo");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se modificó correctamente el tipo de Aseo, el error:"+e.toString());
        
        }
    }
        
    public void deleteTipoAseo(JTextField paramid){
        setId(Integer.parseInt(paramid.getText()));
        
                CConexion Objetoconexion = new CConexion();
        
        String consulta="call EliminarTipoAseo(?);";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);

            es.setInt(1, getId());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se eliminó correctamente el tipo de aseo");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se eliminó correctamente el tipo de aseo, el error:"+e.toString());
        
        }
    }    
}
