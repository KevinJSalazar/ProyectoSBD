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

public class CSolicitud {
    
    int idSer;
    int idUsu;
    
    public void establecerIdSer(int idSer) {
        this.idSer = idSer;
    }

    public void establecerIdUsu(int idUsu) {
        this.idUsu = idUsu;
    }

    public void mostrarUsuario(JComboBox cbx, boolean isCui, String useSql) {
        ActionListener[] actions = cbx.getActionListeners();
        if (actions.length != 0)
            cbx.removeActionListener(actions[0]);
        clases.CConexion objConexion = new clases.CConexion();
        String sql;
        if (useSql != null) sql = useSql;
        else if (isCui) sql = "select u.idUsu, u.nickname from usuario u left join servicio s on u.idUsu = s.idCui where idCui is not null;";
        else sql = "select *  from usuario";
        try {
            Statement st = objConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            cbx.removeAllItems();
            while (rs.next()) {
                String nickname = rs.getString("nickname");
                this.establecerIdUsu(rs.getInt("idUsu"));
                cbx.addItem(nickname);
                cbx.putClientProperty(nickname, idUsu);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al mostar Usuarios: " + e.toString());
        } finally {
            objConexion.cerrarConexion();
        }
        if (actions.length != 0) {
            cbx.addActionListener(actions[0]);
        }
    }

    public void mostrarServicios(JComboBox cbx, int idCui) {
        ActionListener[] actions = cbx.getActionListeners();
        if (actions.length != 0)
            cbx.removeActionListener(actions[0]);
        clases.CConexion objConexion = new clases.CConexion();
        String sql;
        if (idCui == -1) sql = "select * from servicio";
        else sql = "select s.idSer, s.titulo from servicio s where idCui=" + idCui + ";";
        try {
            Statement st = objConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            cbx.removeAllItems();
            while (rs.next()) {
                String titulo = rs.getString("titulo");
                this.establecerIdSer(rs.getInt("idSer"));
                cbx.addItem(titulo);
                cbx.putClientProperty(titulo, idSer);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al mostar Servicios: " + e.toString());
        } finally {
            objConexion.cerrarConexion();
        }
        if (actions.length != 0) {
            cbx.addActionListener(actions[0]);
        }
    }
    
    public void mostrarSolicitud(JTable tbSolicitudes){
        CConexion objetoConexion = new CConexion();
        DefaultTableModel modelo = new DefaultTableModel();
        
        modelo.addColumn("Id");
        modelo.addColumn("Servicio");
        modelo.addColumn("Usuario");
        modelo.addColumn("Cuidador");
        modelo.addColumn("Fecha");
        tbSolicitudes.setModel(modelo);
        
        String sql = "select sol.idSol,s.titulo,u.nickname as nickU,cui.nickname as nickC,sol.fecha from solicitud sol JOIN usuario u ON sol.idUsu = u.idUsu JOIN servicio s ON sol.idSer = s.idSer JOIN usuario cui ON sol.idCui = cui.idUsu;";
        
        try {
            Statement st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("idSol");
                String titulo = rs.getString("titulo");
                String nickU = rs.getString("nickU");
                String nickC = rs.getString("nickC");
                
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date fechaSql = rs.getDate("fecha");
                String nfecha = sdf.format(fechaSql); 
                
                modelo.addRow(new Object[]{id,titulo,nickU,nickC,nfecha});
            }
            tbSolicitudes.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
        }
    }
    
    public void agregarSolicitud(JComboBox cbxSer, JComboBox cbxUsu, JComboBox cbxCui, JDateChooser fecha){
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Solicitud (idSol,idSer,idUsu,idCui,fecha) values(?, ?, ?, ?, ?);";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, 0);
            int servicio = (int)cbxSer.getClientProperty(cbxSer.getSelectedItem());
            cs.setInt(2, servicio);
            int usuario = (int)cbxUsu.getClientProperty(cbxUsu.getSelectedItem());
            int cuidador = (int)cbxCui.getClientProperty(cbxCui.getSelectedItem());
            if(cuidador == usuario) {
                JOptionPane.showMessageDialog(null, "El Usuario y Cuidador deben ser diferentes");
                return;
            }
            cs.setInt(3, usuario);
            cs.setInt(4, cuidador);
            Date fechaSelec = fecha.getDate();
            java.sql.Date fechaSql = new java.sql.Date(fechaSelec.getTime());
            cs.setDate(5, fechaSql);
            cs.execute();
            JOptionPane.showMessageDialog(null, "La solicitud se guardó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "La solicitud no se pudo guardar, error: " + e.toString());
        }
    }
    
    public void seleccionarSolicitud(JTable tbSolicitudes, JTextField id, JComboBox cbxSer, JComboBox cbxUsu, JComboBox cbxCui, JDateChooser fecha){
        ActionListener[] actionsSer = cbxSer.getActionListeners();
        cbxSer.removeActionListener(actionsSer[0]);
        ActionListener[] actionsCui = cbxCui.getActionListeners();
        cbxCui.removeActionListener(actionsCui[0]);  
        int fila = tbSolicitudes.getSelectedRow();
            if (fila >= 0){
                id.setText((tbSolicitudes.getValueAt(fila, 0)).toString());
                cbxSer.setSelectedItem(tbSolicitudes.getValueAt(fila, 1).toString());
                cbxUsu.setSelectedItem(tbSolicitudes.getValueAt(fila, 2).toString());
                cbxCui.setSelectedItem(tbSolicitudes.getValueAt(fila, 3).toString());
                String fechaString = tbSolicitudes.getValueAt(fila, 4).toString();
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    Date fechaDate = sdf.parse(fechaString);
                    fecha.setDate(fechaDate);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(null, "Error de selección, error: " + e.toString());
                }
            }
            else
                JOptionPane.showMessageDialog(null, "Solicitud no seleccionada");
        cbxSer.addActionListener(actionsSer[0]);
        cbxCui.addActionListener(actionsCui[0]);  
    }
    
    public void modificarSolicitud (JTextField id, JComboBox cbxSer, JComboBox cbxUsu, JComboBox cbxCui, JDateChooser fecha){
        if(id.getText().equals(""))
            JOptionPane.showMessageDialog(null, "Seleccione una Solicitud para modificar"); 
        CConexion objetoConexion = new CConexion();
        String consulta = "update solicitud s set s.idSer=?,s.idUsu=?,s.idCui=?,s.fecha=? where s.idSol=?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            int servicio = (int) cbxSer.getClientProperty(cbxSer.getSelectedItem());
            cs.setInt(1, servicio);
            int usuario = (int) cbxUsu.getClientProperty(cbxUsu.getSelectedItem());
            int cuidador = (int) cbxCui.getClientProperty(cbxCui.getSelectedItem());
            if(cuidador == usuario) {
                JOptionPane.showMessageDialog(null, "El Usuario y Cuidador deben ser diferentes");
                return;
            }
            cs.setInt(2, usuario);
            cs.setInt(3, cuidador);
            Date fechaSelec = fecha.getDate();
            java.sql.Date fechaSql = new java.sql.Date(fechaSelec.getTime());
            cs.setDate(4, fechaSql);
            cs.setInt(5,Integer.parseInt(id.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "La solicitud se modificó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "La solicitud no se pudo modificar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
        
    }
    
    public void eliminarSolicitud(JTextField paramId){
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from solicitud where solicitud.idSol = ?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "La solicitud se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "La solicitud no se pudo eliminar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
    }
}
