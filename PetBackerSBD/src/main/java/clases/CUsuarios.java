/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class CUsuarios {
    int id;
    String nombre;
    String correo;
    String contraseña;
    int telefono;
    String foto;
    String redSocial;
    int vales;
    int tarjeta;
    String tipo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getRedSocial() {
        return redSocial;
    }

    public void setRedSocial(String redSocial) {
        this.redSocial = redSocial;
    }

    public int getVales() {
        return vales;
    }

    public void setVales(int vales) {
        this.vales = vales;
    }

    public int getTarjeta() {
        return tarjeta;
    }

    public void setTarjeta(int tarjeta) {
        this.tarjeta = tarjeta;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public void saveUser(JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña){
        setCorreo(paramCorreo.getText());
        setNombre(paramNombre.getText());
        setContraseña(paramContraseña.getText());
        
        CConexion objetoConexion = new CConexion();
        String consulta = "insert into Usuario (email, nickname, contraseña) values(?, ?, ?);";
        
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, getCorreo());
            cs.setString(2, getNombre());
            cs.setString(3, getContraseña());
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
        paramTablaTotalUsuarios.setModel(modelo);
        
        String sql = "select idusu, email, nickname, contraseña from usuario;";
        String[] datos = new String[4];
        Statement st;
        
        try {
            st = objetoConexion.estableceConexion().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                datos[0] = rs.getString(1);
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                datos[3] = rs.getString(4);
                modelo.addRow(datos);
            }
            paramTablaTotalUsuarios.setModel(modelo);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "No se pudo mostrar los registros, error: " + e.toString());
        }
    }
    
    public void selectUser(JTable paramTablaUsuarios, JTextField paramId, JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña){
        try {
            int fila = paramTablaUsuarios.getSelectedRow();
            if (fila >= 0){
                paramId.setText((paramTablaUsuarios.getValueAt(fila, 0)).toString());
                paramCorreo.setText((paramTablaUsuarios.getValueAt(fila, 1)).toString());
                paramNombre.setText((paramTablaUsuarios.getValueAt(fila, 2)).toString());
                paramContraseña.setText((paramTablaUsuarios.getValueAt(fila, 3)).toString());
            }
            else
                JOptionPane.showMessageDialog(null, "Usuario no seleccionado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error de selección, error: " + e.toString());
        }
    }
    
    public void modifyUser(JTextField paramId, JTextField paramCorreo, JTextField paramNombre, JTextField paramContraseña){
        setId(Integer.parseInt(paramId.getText()));
        setCorreo(paramCorreo.getText());
        setNombre(paramNombre.getText());
        setContraseña(paramContraseña.getText());
        CConexion objetoConexion = new CConexion();
        String consulta = "update usuario u set u.email = ?, u.nickname = ?, u.contraseña = ? where u.idusu = ?;";
        
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setString(1, getCorreo());
            cs.setString(2, getNombre());
            cs.setString(3, getContraseña());
            cs.setInt(4, getId());
            cs.execute();
            JOptionPane.showMessageDialog(null, "El usuario se modificó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El usuario no se pudo modificar, error: " + e.toString());
        }
    }
    
    public void deleteUser(JTextField paramId){
        setId(Integer.parseInt(paramId.getText()));
        CConexion objetoConexion = new CConexion();
        String consulta = "delete from usuario u where u.idusu = ?;";
        
        try {
            CallableStatement cs = objetoConexion.estableceConexion().prepareCall(consulta);
            cs.setInt(1, getId());
            cs.execute();
            JOptionPane.showMessageDialog(null, "El usuario se eliminó correctamente.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "El usuario no se pudo eliminar, error: " + e.toString());
        }
    }
}
