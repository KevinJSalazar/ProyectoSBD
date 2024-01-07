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

public class CComentario {
    
    int idUsu;
    int idSer;
    
    public void establecerIdUsu(int idUsu) {
        this.idUsu = idUsu;
    }
    
    public void establecerIdSer(int idSer) {
        this.idSer = idSer;
    }
    
    public void mostrarUsuario(JComboBox cbx, boolean isCui, String useSql){
        ActionListener[] actions = cbx.getActionListeners();
        if(actions.length != 0) cbx.removeActionListener(actions[0]);
        clases.CConexion objConexion = new clases.CConexion();
        String sql;
        if (useSql!=null) sql = useSql;
        else if(isCui) sql = "select u.idUsu, u.nickname from usuario u left join servicio s on u.idUsu = s.idCui where idCui is not null;";
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
            JOptionPane.showMessageDialog(null,"Error al mostar Usuarios: "+e.toString());
        } finally {
            objConexion.cerrarConexion();
        }
        if(actions.length != 0) cbx.addActionListener(actions[0]);
    }
    
    public void mostrarServicios(JComboBox cbx, int idCui){
        ActionListener[] actions = cbx.getActionListeners();
        if(actions.length != 0) cbx.removeActionListener(actions[0]);
        clases.CConexion objConexion = new clases.CConexion();
        String sql;
        if(idCui==-1) sql = "select * from servicio";
        else sql = "select s.idSer, s.titulo from servicio s where idCui="+idCui+";";
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
            JOptionPane.showMessageDialog(null,"Error al mostar Servicios: "+e.toString());
        }
        finally {
            objConexion.cerrarConexion();
        }
        if(actions.length != 0) cbx.addActionListener(actions[0]);
    }
    
    public void insertarComentario(JComboBox idSer, JComboBox idUsu, JComboBox idCui, JDateChooser paramFecha, JTextField paramValoracion, JTextField paramContenido){
        if(!camposLlenos(paramFecha,paramValoracion,paramContenido)) return;
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Comentario (idSol,idSer,idUsu,idCui,fecha,valoracion,contenido) values(?, ?, ?, ?, ?, ?, ?);";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, 0);
            int servicio = (int) idSer.getClientProperty(idSer.getSelectedItem());
            cs.setInt(2, servicio);
            int usuario = (int) idUsu.getClientProperty(idUsu.getSelectedItem());
            int cuidador = (int) idCui.getClientProperty(idCui.getSelectedItem());
            if(cuidador == usuario) {
                JOptionPane.showMessageDialog(null, "El Usuario y Cuidador deben ser diferentes");
                return;
            }
            cs.setInt(3, usuario);
            cs.setInt(4, cuidador);
            Date fechaSelec = paramFecha.getDate();
            java.sql.Date fechaSql = new java.sql.Date(fechaSelec.getTime());
            cs.setDate(5, fechaSql);
            cs.setDouble(6, Double.parseDouble(paramValoracion.getText()));
            cs.setString(7, paramContenido.getText());
            cs.execute();
            JOptionPane.showMessageDialog(null, "El comentario se guardó correctamente.");
        } catch (NumberFormatException n) {
            JOptionPane.showMessageDialog(null, "El campo valoración debe llenarse con números");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El comentario no se pudo guardar, error: " + e.toString());
        }
    }
    
    public void mostrarComentario(JTable paramTablaComentarios){
        CConexion objetoConexion = new CConexion();
        DefaultTableModel modelo = new DefaultTableModel();
        
        modelo.addColumn("Id");
        modelo.addColumn("Servicio");
        modelo.addColumn("Usuario");
        modelo.addColumn("Cuidador");
        modelo.addColumn("Fecha");
        modelo.addColumn("Valoracion");
        modelo.addColumn("Contenido");
        paramTablaComentarios.setModel(modelo);
        
        String sql = "select c.idSol,s.titulo,u.nickname as nickU,cui.nickname as nickC,c.fecha,c.valoracion,c.contenido from comentario c JOIN usuario u ON c.idUsu = u.idUsu JOIN servicio s ON c.idSer = s.idSer JOIN usuario cui ON c.idCui = cui.idUsu;";

        try {
            Statement st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("idSol");
                String titulo = rs.getString("titulo");
                String nickUsu = rs.getString("nickU");
                String nickCui = rs.getString("nickC");
                
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date fechaSql = rs.getDate("fecha");
                String nfecha = sdf.format(fechaSql); 
                
                String valoracion = rs.getString("valoracion");
                String contenido = rs.getString("contenido");
                
                modelo.addRow(new Object[]{id,titulo,nickUsu,nickCui,nfecha,valoracion,contenido});
            }
            paramTablaComentarios.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
    }
    
    public void seleccionarComentario(JTable paramTablaComentarios, JTextField id, JComboBox idSer, JComboBox idUsu, JComboBox idCui, JDateChooser paramFecha, JTextField paramValoracion, JTextField paramContenido){
        ActionListener[] actionsSer = idSer.getActionListeners();
        idSer.removeActionListener(actionsSer[0]);
        ActionListener[] actionsCui = idCui.getActionListeners();
        idCui.removeActionListener(actionsCui[0]);  
        int fila = paramTablaComentarios.getSelectedRow();
            if (fila >= 0){
                id.setText((paramTablaComentarios.getValueAt(fila, 0)).toString());
                idSer.setSelectedItem(paramTablaComentarios.getValueAt(fila, 1).toString());
                idUsu.setSelectedItem(paramTablaComentarios.getValueAt(fila, 2).toString());
                idCui.setSelectedItem(paramTablaComentarios.getValueAt(fila, 3).toString());
                String fechaString = paramTablaComentarios.getValueAt(fila, 4).toString();
                paramValoracion.setText((paramTablaComentarios.getValueAt(fila, 5)).toString());
                paramContenido.setText((paramTablaComentarios.getValueAt(fila, 6)).toString());
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    Date fechaDate = sdf.parse(fechaString);
                    paramFecha.setDate(fechaDate);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(null, "Error de selección, error: " + e.toString());
                }
            }
            else
                JOptionPane.showMessageDialog(null, "Comentario no seleccionado");
        idSer.addActionListener(actionsSer[0]);
        idCui.addActionListener(actionsCui[0]);  
    }
    
    public void modificarComentario (JTextField id, JComboBox idSer, JComboBox idUsu, JComboBox idCui, JDateChooser paramFecha, JTextField paramValoracion, JTextField paramContenido){
        if(id.getText().equals(""))
            JOptionPane.showMessageDialog(null, "Seleccione un Comentario para modificar");
        else if(!camposLlenos(paramFecha,paramValoracion,paramContenido)) return;    
        CConexion objetoConexion = new CConexion();
        String consulta = "update comentario c set c.idSer=?,c.idUsu=?,c.idCui=?,c.fecha=?,c.valoracion=?,c.contenido=? where c.idSol=?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            int servicio = (int) idSer.getClientProperty(idSer.getSelectedItem());
            cs.setInt(1, servicio);
            int usuario = (int) idUsu.getClientProperty(idUsu.getSelectedItem());
            int cuidador = (int) idCui.getClientProperty(idCui.getSelectedItem());
            if(cuidador == usuario) {
                JOptionPane.showMessageDialog(null, "El Usuario y Cuidador deben ser diferentes");
                return;
            }
            cs.setInt(2, usuario);
            cs.setInt(3, cuidador);
            Date fechaSelec = paramFecha.getDate();
            java.sql.Date fechaSql = new java.sql.Date(fechaSelec.getTime());
            cs.setDate(4, fechaSql);
            cs.setDouble(5, Double.parseDouble(paramValoracion.getText()));
            cs.setString(6, paramContenido.getText());
            cs.setInt(7,Integer.parseInt(id.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El comentario se modificó correctamente.");
        } catch (NumberFormatException n) {
            JOptionPane.showMessageDialog(null, "El campo valoración debe llenarse con números");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El comentario no se pudo modificar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
    }
    
    public void eliminarComentario(JTextField paramId){
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from comentario where comentario.idSol = ?;";
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El comentario se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El comentario no se pudo eliminar, error: " + e.toString());
        } finally {
            objetoConexion.cerrarConexion();
        }
    }
    
    public boolean camposLlenos(JDateChooser paramFecha, JTextField paramValoracion, JTextField paramContenido){
        if(paramFecha.getDate()==null || paramValoracion.getText().equals("") || paramContenido.getText().equals("")){
            JOptionPane.showMessageDialog(null, "Llene todos los campos");
            return false;
        }
        return true;
    }
}