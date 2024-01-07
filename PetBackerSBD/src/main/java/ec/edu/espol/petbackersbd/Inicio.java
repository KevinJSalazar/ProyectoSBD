/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ec.edu.espol.petbackersbd;

import formularios.FormUsuario;
import ec.edu.espol.petbackersbd.FormDonación;

/**
 *
 * @author evin
 */
public class Inicio {
    
    public static void main(String[] args) {
        //FormUsuario objetoFormulario = new FormUsuario();
        //objetoFormulario.setVisible(true);
        
        FormDonación objetoDonacion = new FormDonación();
        objetoDonacion.setVisible(true);
        
        FormServicio objetoServicio = new FormServicio();
        objetoServicio.setVisible(true);
    }
}
