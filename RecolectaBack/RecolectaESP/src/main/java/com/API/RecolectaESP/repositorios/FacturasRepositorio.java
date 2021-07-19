package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Facturas;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;


import java.sql.*;
import java.util.List;

public interface FacturasRepositorio extends JpaRepository<Facturas,Long> {


    @Transactional(readOnly=true)
    @Query("FROM Facturas factura WHERE factura.contratista.contratistaId = :contratista_id ORDER BY factura.facturaInicioPeriodo DESC")
    public List<Facturas> findFacturasByContratistaId(@Param("contratista_id") Long contratista_id);

    @Transactional(readOnly=true)
    @Query("FROM Facturas factura WHERE factura.centroDisposicion.centroDisposicionId = :centro_disposicion_id ORDER BY factura.facturaInicioPeriodo DESC")
    public List<Facturas> findFacturasByCentroDisposionId(@Param("centro_disposicion_id") Long centro_disposicion_id);

    @Transactional(readOnly=true)
    public Facturas findFacturasByFacturaId(Long factura_id);

    @Transactional(readOnly=true)
    public default void generarFacturas() throws ClassNotFoundException, SQLException {

        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            //Conexión a la BD
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.15:1521/XEPDB1", "recolecta", "6488");

            CallableStatement cs= con.prepareCall("{call FACTURACION.facturacion_masiva()}");

            //cs.setInt(1, Math.toIntExact(contratista_id));

            cs.execute();



        } catch (Exception ex) {
            System.out.println(ex);
        }
    }


}
