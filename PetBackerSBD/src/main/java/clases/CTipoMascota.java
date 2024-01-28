/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class CTipoMascota {
    int id;
    int idTipo_ser;
    String mascota;

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

    public String getMascota() {
        return mascota;
    }

    public void setMascota(String mascota) {
        this.mascota = mascota;
    }


    
    public void saveTipoMascota(JTextField paramidtipserv, JComboBox parammascota){
        
        setIdTipo_ser(Integer.parseInt(paramidtipserv.getText()));
        setMascota(parammascota.getSelectedItem().toString());
        
        CConexion objetoconexion = new CConexion();
        
        String consulta="call InsertarTipoMascotas(?,?);";
        
        try{
            CallableStatement es = objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setInt(1, getIdTipo_ser());
            es.setString(2, getMascota());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente el tipo de mascota");
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, "No se insertó correctamente el tipo de mascota, el Error:"+e.toString());
        }
    }
    
    public void showTipoMascota(JTable paramTablaTotalTipoAseo){
        
        CConexion Objetoconexion = new CConexion();
        
        DefaultTableModel model = new DefaultTableModel();
        
        TableRowSorter<TableModel> OrdenarTabla = new TableRowSorter<TableModel>(model);
    
        String sql="";
        
        model.addColumn("id");
        model.addColumn("idTipoAseo");
        model.addColumn("Mascota");
        
        paramTablaTotalTipoAseo.setModel(model);
        
        sql = "Select * from TipoMascotas;";
        
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
    
    public void selectTipoMascota(JTable paramTablaTotalTipoAseo, JTextField paramid, JTextField paramidtipserv, JComboBox parammascota){
        
        try{
            int fila = paramTablaTotalTipoAseo.getSelectedRow();
            
            if(fila >= 0){
                
                paramid.setText(paramTablaTotalTipoAseo.getValueAt(fila, 0).toString());
                paramidtipserv.setText(paramTablaTotalTipoAseo.getValueAt(fila, 1).toString());
                parammascota.setSelectedItem(paramTablaTotalTipoAseo.getValueAt(fila, 2).toString());
            }
            else
                JOptionPane.showMessageDialog(null, "Fila no seleccionada");
        
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error de selección, el error:"+e.toString());
        }
    }
    
        public void modifyTipoMascota(JTextField paramid, JTextField paramidtipserv, JComboBox parammascota){
        setId(Integer.parseInt(paramid.getText()));
        setIdTipo_ser(Integer.parseInt(paramidtipserv.getText()));
        setMascota(parammascota.getSelectedItem().toString());
        
        CConexion Objetoconexion = new CConexion();
        
        String consulta="call ActualizarTipoMascotas(?,?,?);";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setInt(1, getId());
            es.setInt(2, getIdTipo_ser());
            es.setString(3, getMascota());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se modificó correctamente el tipo de mascota");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se modificó correctamente el tipo de mascota, el error:"+e.toString());
        
        }
    }
        
    public void deleteTipoMascota(JTextField paramid){
        setId(Integer.parseInt(paramid.getText()));
        
                CConexion Objetoconexion = new CConexion();
        
        String consulta="call EliminarTipoMascotas(?);";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);

            es.setInt(1, getId());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se eliminó correctamente el tipo de mascota");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se eliminó correctamente el tipo de mascota, el error:"+e.toString());
        
        }
    }     
}
