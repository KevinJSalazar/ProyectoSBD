/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import com.toedter.calendar.JDateChooser;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import javax.swing.JCheckBox;
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
public class CTipodeServicio {
    int id;
    String lugar_recogida;
    Date fechaInicio;
    Date fechaFin;
    int Can_Dias;
    String Detalles;
    String Raza;
    int Can_Mascotas;
    String esTipo;
    Boolean recoger;
    int Can_Paseos;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLugar_recogida() {
        return lugar_recogida;
    }

    public void setLugar_recogida(String lugar_recogida) {
        this.lugar_recogida = lugar_recogida;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaIncio) {
        this.fechaInicio = fechaIncio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public int getCan_Dias() {
        return Can_Dias;
    }

    public void setCan_Dias(int Can_Dias) {
        this.Can_Dias = Can_Dias;
    }

    public String getDetalles() {
        return Detalles;
    }

    public void setDetalles(String Detalles) {
        this.Detalles = Detalles;
    }

    public String getRaza() {
        return Raza;
    }

    public void setRaza(String Raza) {
        this.Raza = Raza;
    }

    public int getCan_Mascotas() {
        return Can_Mascotas;
    }

    public void setCan_Mascotas(int Can_Mascotas) {
        this.Can_Mascotas = Can_Mascotas;
    }

    public String getEsTipo() {
        return esTipo;
    }

    public void setEsTipo(String esTipo) {
        this.esTipo = esTipo;
    }

    public Boolean getRecoger() {
        return recoger;
    }

    public void setRecoger(Boolean recoger) {
        this.recoger = recoger;
    }

    public int getCan_Paseos() {
        return Can_Paseos;
    }

    public void setCan_Paseos(int Can_Paseos) {
        this.Can_Paseos = Can_Paseos;
    }  
    
    public void saveTip_of_Serv(JTextField paramlugar, JDateChooser paraminicio,  JTextField paramdias, JDateChooser paramfin, JTextField paramdetalles, JTextField paramraza, JTextField parammascotas,JTextField paramestipo, JCheckBox paramrecogida, JTextField parampaseos){
        setLugar_recogida(paramlugar.getText());
        setFechaInicio(new java.sql.Date(paraminicio.getDate().getTime()));
        setCan_Dias(Integer.parseInt(paramdias.getText()));
        setFechaFin(new java.sql.Date(paramfin.getDate().getTime()));
        setDetalles(paramdetalles.getText());
        setRaza(paramraza.getText());
        setCan_Mascotas(Integer.parseInt(parammascotas.getText()));
        setEsTipo(paramestipo.getText());
        setRecoger(paramrecogida.isSelected());
        setCan_Paseos(Integer.parseInt(parampaseos.getText()));
        
        CConexion Objetoconexion = new CConexion();
        
        String consulta="insert into TipoServicio (lugar_recogida, fecha_inicio, numero_dias, fecha_fin, detalles, raza, numero_mascotas, tipo, servicio_recogida, numero_paseos_diario) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setString(1, getLugar_recogida());
            es.setDate(2, getFechaInicio());
            es.setInt(3, getCan_Dias());
            es.setDate(4, getFechaFin());
            es.setString(5, getDetalles());
            es.setString(6, getRaza());
            es.setInt(7, getCan_Mascotas());
            es.setString(8,getEsTipo());
            es.setBoolean(9, getRecoger());
            es.setInt(10, getCan_Paseos());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se insertó correctamente el tipo de servicio");
        }
        catch(Exception e){
            
            JOptionPane.showMessageDialog(null, "No se insertó correctamente el tipo de servicio, el error:"+e.toString());
        
        }
    }
    
    public void showTip_of_serv(JTable paramTablaTotalTip_of_Serv){
        
        CConexion Objetoconexion = new CConexion();
        
        DefaultTableModel model = new DefaultTableModel();
        
        TableRowSorter<TableModel> OrdenarTabla = new TableRowSorter<TableModel>(model);
    
        String sql="";
        
        model.addColumn("id");
        model.addColumn("Lugar de recogida");
        model.addColumn("Fecha inicio");
        model.addColumn("Cantidad de dias");
        model.addColumn("Fecha final");
        model.addColumn("Detalles");
        model.addColumn("Raza");
        model.addColumn("Cantidad de mascotas");
        model.addColumn("Es tipo");
        model.addColumn("Recoger");
        model.addColumn("Numero de paseos Darios");
        
        paramTablaTotalTip_of_Serv.setModel(model);
        
        sql = "Select * from TipoServicio;";
        
        String[] datos = new String[11];
        Statement st;
        
        try{
            st= Objetoconexion.estableceConexion().createStatement();
            
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                datos[0]= rs.getString(1);
                datos[1]= rs.getString(2);
                datos[2]= rs.getString(3);
                datos[3]= rs.getString(4);
                datos[4]= rs.getString(5);
                datos[5]= rs.getString(6);
                datos[6]= rs.getString(7);
                datos[7]= rs.getString(8);
                datos[8]= rs.getString(9);
                datos[9]= rs.getString(10);
                datos[10]= rs.getString(11);
                
                model.addRow(datos);
                
            }
            
            paramTablaTotalTip_of_Serv.setModel(model);
        }
        catch(Exception e){
            
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, el error:"+e.toString());
        }
                  
    }
    
    public void selectTip_of_Serv(JTable paramTablaTotalTip_of_Serv, JTextField paramid, JTextField paramlugar, JDateChooser paraminicio, JTextField paramdias, JDateChooser paramfin, JTextField paramdetalles, JTextField paramraza, JTextField parammascotas,JTextField paramestipo, JCheckBox paramrecogida, JTextField parampaseos ){
        
        try{
            int fila = paramTablaTotalTip_of_Serv.getSelectedRow();
            
            if(fila >= 0){
                
                paramid.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 0).toString());
                paramlugar.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 1).toString());
                
                String fechainicio = paramTablaTotalTip_of_Serv.getValueAt(fila, 2).toString();
                
                paramdias.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 3).toString());
                
                String fechafin = paramTablaTotalTip_of_Serv.getValueAt(fila, 4).toString();
                
                paramraza.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 6).toString());
                parammascotas.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 7).toString());
                paramestipo.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 8).toString());

                String bool = paramTablaTotalTip_of_Serv.getValueAt(fila, 9).toString();
                
                if(bool.equals("1"))
                    paramrecogida.setSelected(true); 
                else
                    paramrecogida.setSelected(false); 
                    
                try{
                    paramdetalles.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 5).toString());

                }
                catch(Exception e){
                    paramdetalles.setText("");
                }
                
                try{
                    parampaseos.setText(paramTablaTotalTip_of_Serv.getValueAt(fila, 10).toString());

                }
                catch(Exception e){
                    parampaseos.setText("");
                }
                                
                try{
                    java.sql.Date sqlDate = java.sql.Date.valueOf(fechainicio);
                    java.sql.Date sqlDate2 = java.sql.Date.valueOf(fechafin);
                    
                    paraminicio.setDate(new java.util.Date(sqlDate.getTime()));
                    paramfin.setDate(new java.util.Date(sqlDate2.getTime()));
                }
                catch(Exception e){
                    JOptionPane.showMessageDialog(null, "Error al seleciionar, el error:"+e.toString());
                }
            }
            else
                JOptionPane.showMessageDialog(null, "Fila no seleccionada");
        
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error de selección, el error:"+e.toString());
        }
    }
    
    public void modifyTip_of_Serv(JTextField paramid, JTextField paramlugar, JDateChooser paraminicio, JTextField paramdias, JDateChooser paramfin, JTextField paramdetalles, JTextField paramraza, JTextField parammascotas,JTextField paramestipo, JCheckBox paramrecogida, JTextField parampaseos ){
        setId(Integer.parseInt(paramid.getText()));
        setLugar_recogida(paramlugar.getText());
        setFechaInicio(new java.sql.Date(paraminicio.getDate().getTime()));
        setCan_Dias(Integer.parseInt(paramdias.getText()));
        setFechaFin(new java.sql.Date(paramfin.getDate().getTime()));
        setDetalles(paramdetalles.getText());
        setRaza(paramraza.getText());
        setCan_Mascotas(Integer.parseInt(parammascotas.getText()));
        setEsTipo(paramestipo.getText());
        setRecoger(paramrecogida.isSelected());
        setCan_Paseos(Integer.parseInt(parampaseos.getText()));
        
        CConexion Objetoconexion = new CConexion();
        
        String consulta="UPDATE TipoServicio SET tiposervicio.lugar_recogida = ?, tiposervicio.fecha_inicio = ?, tiposervicio.numero_dias = ?, tiposervicio.fecha_fin = ?, tiposervicio.detalles = ?, tiposervicio.raza = ?, tiposervicio.numero_mascotas = ?, tiposervicio.tipo = ?, tiposervicio.servicio_recogida = ?, tiposervicio.numero_paseos_diario = ? WHERE tiposervicio.idTipoSer = ?;";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);
            
            es.setString(1, getLugar_recogida());
            es.setDate(2, getFechaInicio());
            es.setInt(3, getCan_Dias());
            es.setDate(4, getFechaFin());
            es.setString(5, getDetalles());
            es.setString(6, getRaza());
            es.setInt(7, getCan_Mascotas());
            es.setString(8,getEsTipo());
            es.setBoolean(9, getRecoger());
            es.setInt(10, getCan_Paseos());
            es.setInt(11, getId());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se modificó correctamente el tipo de servicio");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se modificó correctamente el tipo de servicio, el error:"+e.toString());
        
        }
    }
    
    public void deleteTip_of_Serv(JTextField paramid){
        setId(Integer.parseInt(paramid.getText()));
        
                CConexion Objetoconexion = new CConexion();
        
        String consulta="DELETE FROM TipoServicio Where tiposervicio.idTipoSer = ?";
        
        try{
            CallableStatement es = Objetoconexion.estableceConexion().prepareCall(consulta);

            es.setInt(1, getId());
            
            es.execute();
            
            JOptionPane.showMessageDialog(null, "Se eliminó correctamente el tipo de servicio");
        }
        catch(SQLException e){
            
            JOptionPane.showMessageDialog(null, "No se eliminó correctamente el tipo de servicio, el error:"+e.toString());
        
        }
    }
}
