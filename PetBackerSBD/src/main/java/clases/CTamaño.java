package clases;

import com.toedter.calendar.JDateChooser;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

public class CTamaño {

    public void mostrarTipoServicio(JComboBox cbx) {
        clases.CConexion objConexion = new clases.CConexion();
        String sql = "select * from TipoServicio";
        try {
            Statement st = objConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            cbx.removeAllItems();
            while (rs.next()) {
                String id = rs.getString("idTipoSer");
                cbx.addItem(id);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al mostar Tipos de Servicios: " + e.toString());
        } finally {
            objConexion.cerrarConexion();
        }
    }
    
    public void mostrarTamaño(JTable tbSolicitudes){
        CConexion objetoConexion = new CConexion();
        DefaultTableModel modelo = new DefaultTableModel();
        
        modelo.addColumn("Id");
        modelo.addColumn("IdTipoServicio");
        modelo.addColumn("Tamaño");
        modelo.addColumn("Titulo");
        modelo.addColumn("Tipo");
        modelo.addColumn("Fecha inicio");
        modelo.addColumn("Fecha fin");
        modelo.addColumn("Raza");
        modelo.addColumn("Lugar Recogida");
        modelo.addColumn("Detalles");
        tbSolicitudes.setModel(modelo);
        
        String sql = "select t.idTam,tp.idTipoSer,t.tamaño,s.titulo,tp.tipo,tp.fecha_inicio,tp.fecha_fin,tp.raza,tp.lugar_recogida,tp.detalles from tamaño t natural join tipoServicio tp natural join servicio s;";
        
        try {
            Statement st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                String idTam = rs.getString("idTam");
                String idTpSer = rs.getString("idTipoSer");
                String tamaño = rs.getString("tamaño");
                String titulo = rs.getString("titulo");
                String tipo = rs.getString("tipo");
                String fecha_inicio = rs.getString("fecha_inicio");
                String fecha_fin = rs.getString("fecha_fin");
                String raza = rs.getString("raza");
                String lugar_recogida = rs.getString("lugar_recogida");
                String detalles = rs.getString("detalles");

                modelo.addRow(new Object[]{idTam,idTpSer,tamaño,titulo,tipo,fecha_inicio,fecha_fin,raza,lugar_recogida,detalles});
            }
            tbSolicitudes.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
        }
    }
    
    public void agregarTamaño(JComboBox cbxSer,  JComboBox tamaño){
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Tamaño (idTam,idTipoSer,tamaño) values(?, ?, ?);";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, 0);
            String servicio = (String)cbxSer.getSelectedItem();
            cs.setInt(2, Integer.parseInt(servicio));
            cs.setString(3, (String)tamaño.getSelectedItem());
            cs.execute();
            JOptionPane.showMessageDialog(null, "El tamaño se guardó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El tamaño no se pudo guardar, error: " + e.toString());
        }
    }
    
    public void modificarTamaño (JTextField id, JComboBox cbxSer,  JComboBox tamaño){
        if(id.getText().equals(""))
            JOptionPane.showMessageDialog(null, "Seleccione una Tamaño para modificar"); 
        CConexion objetoConexion = new CConexion();
        String consulta = "update tamaño t set t.idTipoSer=?,t.tamaño=? where t.idTam=?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            String servicio = (String)cbxSer.getSelectedItem();
            cs.setInt(1, Integer.parseInt(servicio));
            cs.setString(2, (String)tamaño.getSelectedItem());
            cs.setInt(3,Integer.parseInt(id.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El tamaño se modificó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El tamaño no se pudo modificar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
        
    }
    
    public void seleccionarTamaño(JTable tb, JTextField id, JComboBox cbxSer, JComboBox tamaño){
        int fila = tb.getSelectedRow();
            if (fila >= 0){
                id.setText((tb.getValueAt(fila, 0)).toString());
                cbxSer.setSelectedItem(tb.getValueAt(fila, 1).toString());
                tamaño.setSelectedItem(tb.getValueAt(fila, 2).toString());
            } else
                JOptionPane.showMessageDialog(null, "Tamaño no seleccionado");
    }
    
    public void eliminarTamaño(JTextField paramId){
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from tamaño where tamaño.idTam = ?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El tamaño se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El tamañono se pudo eliminar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
    }
    
}
