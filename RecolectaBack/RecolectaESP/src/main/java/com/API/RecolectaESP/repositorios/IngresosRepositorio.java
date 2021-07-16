package com.API.RecolectaESP.repositorios;


import com.API.RecolectaESP.Proyecciones.IngresosProyeccion;
import com.API.RecolectaESP.modelos.Ingresos;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.sql.*;
import java.util.List;

public interface IngresosRepositorio extends JpaRepository<Ingresos,Long> {

    @Transactional(readOnly=true)
    @Query(value = "SELECT vehiculo_marca marca,vehiculo_placa placa, SUM(ingreso_valor_transporte) valorTransportado FROM ingresos i INNER JOIN (SELECT  vehiculo_placa,  vehiculo_marca,  vehiculo_id     FROM  vehiculos ) v ON i.vehiculo_id = v.vehiculo_id WHERE i.factura_id = :factura_id GROUP BY v.vehiculo_placa, v.vehiculo_marca"
    ,nativeQuery = true)
    public List<IngresosProyeccion> findIngresosByFacturaId(Long factura_id);




    public static String crearIngreso(ObjectNode ingreso) throws ClassNotFoundException, SQLException {
        try {
     Class.forName("oracle.jdbc.driver.OracleDriver");
     Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.15:1521/XEPDB1", "recolecta", "6488");

     CallableStatement cs= con.prepareCall("{call registrar_ingreso.crear_ingreso(?,?,?,?,?,?,?,?,?)}");

     int  peso, conductor, desecho, trabajador, contratista, vehiculo, centro;


     System.out.println(ingreso);

     peso = ingreso.get("ingreso_peso").asInt();
     conductor = ingreso.get("conductor_id").asInt();
     desecho = ingreso.get("desecho_id").asInt();
     trabajador = ingreso.get("trabajador_id").asInt();
     contratista = ingreso.get("contratista_id").asInt();
     vehiculo = ingreso.get("vehiculo_id").asInt();
     centro = ingreso.get("centro_disposicion_id").asInt();


     cs.setInt(1,peso);
     cs.setInt(2,conductor);
     cs.setInt(3,desecho);
     cs.setInt(4,trabajador);
     cs.setInt(5,contratista);
     cs.setInt(6,vehiculo);
     cs.setInt(7,centro);


     cs.registerOutParameter(8, Types.INTEGER);
     cs.registerOutParameter(9, Types.VARCHAR);

     cs.execute();

     int celda_id = cs.getInt(8);
     String celda_nombre = cs.getString(9);


     return celda_nombre;

        } catch (Exception ex) {
     System.out.println(ex);
     return null;
        }
    }

}
