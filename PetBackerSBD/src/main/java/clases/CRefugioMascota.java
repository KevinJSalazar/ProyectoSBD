/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.awt.Image;
import java.io.File;
import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.ImageIcon;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

/**
 *
 * @author evin
 */
public class CRefugioMascota {
    
    public void saveShelter(JTextField correo, JTextField nombre, JTextArea descripcion, File foto, JTextField paginaWeb, JTextField direccion, JTextField estado, JTextField ciudad, JTextField telefono, JTextField telefonoOp){
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Refugiomascotas (email, nombre, descripcion, foto, pagina_web, direccion, estado, ciudad, telefono, telefonoOp) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        
        try {
            FileInputStream fis = new FileInputStream(foto);
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, correo.getText());
            cs.setString(2, nombre.getText());
            cs.setString(3, descripcion.getText());
            cs.setBinaryStream(4, fis, (int)foto.length());
            cs.setString(5, paginaWeb.getText());
            cs.setString(6, direccion.getText());
            cs.setString(7, estado.getText());
            cs.setString(8, ciudad.getText());
            cs.setString(9, telefono.getText());
            cs.setString(10, telefonoOp.getText());
            cs.execute();
            JOptionPane.showMessageDialog(null, "El refugio se guardó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El refugio no se pudo guardar, error: " + e.toString());
        }
    }
    
    public void showShelters(JTable tablaTotalRefugios){
        CConexion objetoConexion = new CConexion();
        DefaultTableModel modelo = new DefaultTableModel();
        TableRowSorter<TableModel> OrdernarTabla = new TableRowSorter<TableModel>(modelo);
        tablaTotalRefugios.setRowSorter(OrdernarTabla);
        
        modelo.addColumn("Id");
        modelo.addColumn("Correo");
        modelo.addColumn("Nombre");
        modelo.addColumn("Descripcion");
        modelo.addColumn("Foto");
        modelo.addColumn("Página web");
        modelo.addColumn("Dirección");
        modelo.addColumn("Estado");
        modelo.addColumn("Ciudad");
        modelo.addColumn("Teléfono");
        modelo.addColumn("Teléfono Opcional");
        tablaTotalRefugios.setModel(modelo);
        
        String sql = "select * from refugiomascotas;";
        
        try {
            Statement st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("idRef");
                String correo = rs.getString("email");
                String nombre= rs.getString("nombre");
                String descripcion = rs.getString("descripcion");
                String paginaWeb = rs.getString("pagina_web");
                String direccion = rs.getString("direccion");
                String estado = rs.getString("estado");
                String ciudad = rs.getString("ciudad");
                String telefono = rs.getString("telefono");
                String telefonoOp = rs.getString("telefonoOp");
                
                byte [] imagesBytes = rs.getBytes("foto");
                Image foto = null;
                if(imagesBytes != null){
                    try{
                        ImageIcon imageIcon = new ImageIcon(imagesBytes);
                        foto = imageIcon.getImage();
                    }
                    catch (Exception e){
                        JOptionPane.showMessageDialog(null, "Error: " + e.toString());
                    }
                }
                modelo.addRow(new Object[]{id,correo,nombre,descripcion,foto,paginaWeb,direccion,estado,ciudad,telefono,telefonoOp});
            }
            tablaTotalRefugios.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al cargar los registros: " + e.toString());
        }
    }
    
    public void selectShelters(JTable tablaRefugios, JTextField id, JTextField correo, JTextField nombre, JTextArea descripcion, JLabel foto, JTextField paginaWeb, JTextField direccion, JTextField estado, JTextField ciudad, JTextField telefono, JTextField telefonoOp){
        try {
            int fila = tablaRefugios.getSelectedRow();
            if (fila >= 0){
                id.setText((tablaRefugios.getValueAt(fila, 0)).toString());
                correo.setText((tablaRefugios.getValueAt(fila, 1)).toString());
                nombre.setText((tablaRefugios.getValueAt(fila, 2)).toString());
                descripcion.setText((tablaRefugios.getValueAt(fila, 3)).toString());
                paginaWeb.setText((tablaRefugios.getValueAt(fila, 5)).toString());
                direccion.setText((tablaRefugios.getValueAt(fila, 6)).toString());
                estado.setText((tablaRefugios.getValueAt(fila, 7)).toString());
                ciudad.setText((tablaRefugios.getValueAt(fila, 8)).toString());
                telefono.setText((tablaRefugios.getValueAt(fila, 9)).toString());
                telefonoOp.setText((tablaRefugios.getValueAt(fila, 10)).toString());
                
                Image imagen = (Image) tablaRefugios.getValueAt(fila, 4);
                ImageIcon originalIcon = new ImageIcon(imagen);
                int lblwidth = foto.getWidth();
                int lblheight = foto.getHeight();
                Image scaledImage = originalIcon.getImage().getScaledInstance(lblwidth, lblheight, Image.SCALE_SMOOTH);
                foto.setIcon(new ImageIcon(scaledImage));
            }
            else
                JOptionPane.showMessageDialog(null, "Refugio no seleccionado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error de selección, error: " + e.toString());
        }
    }
    
    public void modifyShelters(JTextField id, JTextField correo, JTextField nombre, JTextArea descripcion, File foto, JTextField paginaWeb, JTextField direccion, JTextField estado, JTextField ciudad, JTextField telefono, JTextField telefonoOp){
        CConexion objetoConexion = new CConexion();
        String consulta = "update refugiomascotas rm set rm.email = ?, rm.nombre = ?, rm.descripcion = ?, rm.foto = ?, rm.pagina_web = ?, rm.direccion = ?, rm.estado = ?, rm.ciudad = ?, rm.telefono = ?, rm.telefonoOp = ? where rm.idref = ?;";
        
        try {
            FileInputStream fis = new FileInputStream(foto);
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, correo.getText());
            cs.setString(2, nombre.getText());
            cs.setString(3, descripcion.getText());
            cs.setBinaryStream(4, fis,(int)foto.length());
            cs.setString(5, paginaWeb.getText());
            cs.setString(6, direccion.getText());
            cs.setString(7, estado.getText());
            cs.setString(8, ciudad.getText());
            cs.setString(9, telefono.getText());
            cs.setString(10, telefonoOp.getText());
            cs.setInt(11, Integer.parseInt(id.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El refugio se modificó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El refugio no se pudo modificar, error: " + e.toString());
        }
    }
    
    public void deleteShelter(JTextField paramId){
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from refugiomascotas rm where rm.idRef = ?;";
        
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El refugio se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El refugio no se pudo eliminar, error: " + e.toString());
        }
    }
}
