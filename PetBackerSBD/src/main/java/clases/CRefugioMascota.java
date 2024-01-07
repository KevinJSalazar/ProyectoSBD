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
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

/**
 *
 * @author evin
 */
public class CRefugioMascota {
    
    public void saveUser(JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña, JTextField paramTelefono, File foto, JTextField paramRedSocial, JTextField paramVales, JTextField paramTarjeta, JComboBox comboTipo){
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Usuario (email, nickname, contraseña, telefono, foto, red_social, vales, tarjeta, tipo) values(?, ?, ?, ?, ?, ?, ?, ?, ?);";
        
        try {
            FileInputStream fis = new FileInputStream(foto);
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, paramCorreo.getText());
            cs.setString(2, paramNombre.getText());
            cs.setString(3, paramContraseña.getText());
            cs.setString(4, paramTelefono.getText());
            cs.setBinaryStream(5, fis, (int)foto.length());
            cs.setString(6, paramRedSocial.getText());
            cs.setString(7, paramVales.getText());
            cs.setInt(8, Integer.parseInt(paramTarjeta.getText()));
            String tipoUsuario = comboTipo.getSelectedItem().toString();
            cs.setString(9, tipoUsuario);
            cs.execute();
            JOptionPane.showMessageDialog(null, "El usuario se guardó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El usuario no se pudo guardar, error: " + e.toString());
        }
    }
    
    public void showUsers(JTable paramTablaTotalUsuarios){
        CConexion objetoConexion = new CConexion();
        DefaultTableModel modelo = new DefaultTableModel();
        TableRowSorter<TableModel> OrdernarTabla = new TableRowSorter<TableModel>(modelo);
        paramTablaTotalUsuarios.setRowSorter(OrdernarTabla);
        
        modelo.addColumn("Id");
        modelo.addColumn("Correo");
        modelo.addColumn("Nombre");
        modelo.addColumn("Contraseña");
        modelo.addColumn("Telefono");
        modelo.addColumn("Foto");
        modelo.addColumn("Red Social");
        modelo.addColumn("Vales");
        modelo.addColumn("Tarjeta");
        modelo.addColumn("Tipo");
        paramTablaTotalUsuarios.setModel(modelo);
        
        String sql = "select * from usuario;";
        
        try {
            Statement st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("idusu");
                String correo = rs.getString("email");
                String nombre= rs.getString("nickname");
                String contraseña = rs.getString("contraseña");
                String telefono = rs.getString("telefono");
                String redSocial = rs.getString("red_social");
                String vales = rs.getString("vales");
                String tarjeta = rs.getString("tarjeta");
                String tipo = rs.getString("tipo");
                
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
                
                modelo.addRow(new Object[]{id,correo,nombre,contraseña,telefono,foto,redSocial,vales,tarjeta,tipo});
            }
            paramTablaTotalUsuarios.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
        }
    }
    
    public void selectUser(JTable tablaUsuarios, JTextField paramId, JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña, JTextField paramTelefono, JLabel foto, JTextField paramRedSocial, JTextField paramVales, JTextField paramTarjeta, JComboBox comboTipo){
        try {
            int fila = tablaUsuarios.getSelectedRow();
            if (fila >= 0){
                paramId.setText((tablaUsuarios.getValueAt(fila, 0)).toString());
                paramCorreo.setText((tablaUsuarios.getValueAt(fila, 1)).toString());
                paramNombre.setText((tablaUsuarios.getValueAt(fila, 2)).toString());
                paramContraseña.setText((tablaUsuarios.getValueAt(fila, 3)).toString());
                paramTelefono.setText((tablaUsuarios.getValueAt(fila, 4)).toString());
                paramRedSocial.setText((tablaUsuarios.getValueAt(fila, 6)).toString());
                paramVales.setText((tablaUsuarios.getValueAt(fila, 7)).toString());
                paramTarjeta.setText((tablaUsuarios.getValueAt(fila, 8)).toString());
                comboTipo.setSelectedItem((tablaUsuarios.getValueAt(fila, 9)).toString());
                
                Image imagen = (Image) tablaUsuarios.getValueAt(fila, 5);
                ImageIcon originalIcon = new ImageIcon(imagen);
                int lblwidth = foto.getWidth();
                int lblheight = foto.getHeight();
                Image scaledImage = originalIcon.getImage().getScaledInstance(lblwidth, lblheight, Image.SCALE_SMOOTH);
                foto.setIcon(new ImageIcon(scaledImage));
            }
            else
                JOptionPane.showMessageDialog(null, "Usuario no seleccionado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error de selección, error: " + e.toString());
        }
    }
    
    public void modifyUser(JTextField paramId, JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña, JTextField paramTelefono, File foto, JTextField paramRedSocial, JTextField paramVales, JTextField paramTarjeta, JComboBox comboTipo){
        CConexion objetoConexion = new CConexion();
        String consulta = "update usuario u set u.email = ?, u.nickname = ?, u.contraseña = ?, u.telefono = ?, u.foto = ?, u.red_social = ?, u.vales = ?, u.tarjeta = ?, u.tipo = ? where u.idusu = ?;";
        
        try {
            FileInputStream fis = new FileInputStream(foto);
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, paramCorreo.getText());
            cs.setString(2, paramNombre.getText());
            cs.setString(3, paramContraseña.getText());
            cs.setString(4, paramTelefono.getText());
            cs.setBinaryStream(5, fis,(int)foto.length());
            cs.setString(6, paramRedSocial.getText());
            cs.setInt(7, Integer.parseInt(paramVales.getText()));
            cs.setInt(8, Integer.parseInt(paramTarjeta.getText()));
            cs.setString(9, comboTipo.getSelectedItem().toString());
            cs.setInt(10, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El usuario se modificó correctamente.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "El usuario no se pudo modificar, error: " + e.toString());
        }
    }
    
    public void deleteUser(JTextField paramId){
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from usuario u where u.idusu = ?;";
        
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, Integer.parseInt(paramId.getText()));
            cs.execute();
            JOptionPane.showMessageDialog(null, "El usuario se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El usuario no se pudo eliminar, error: " + e.toString());
        }
    }
}
