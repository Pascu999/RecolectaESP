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
    @Query("FROM Facturas factura WHERE factura.contratista.contratistaId = :contratista_id")
    public List<Facturas> findFacturasByContratistaId(@Param("contratista_id") Long contratista_id);

    @Transactional(readOnly=true)
    @Query("FROM Facturas factura WHERE factura.centroDisposicion.centroDisposicionId = :centro_disposicion_id")
    public List<Facturas> findFacturasByCentroDisposionId(@Param("centro_disposicion_id") Long centro_disposicion_id);

    @Transactional(readOnly=true)
    public Facturas findFacturasByFacturaId(Long factura_id);

    @Transactional(readOnly=true)
    public default void generarFacturasContratista(Long contratista_id) throws ClassNotFoundException, SQLException {

        System.out.println("contratista_id");
        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XEPDB1", "demo_teamb", "6488");

            CallableStatement cs= con.prepareCall("{call FACTURACION.Facturar_ingresos_contratista(?)}");

            cs.setInt(1, Math.toIntExact(contratista_id));

            System.out.println("Hasta aqui bien");

            cs.execute();



        } catch (Exception ex) {
            System.out.println(ex);
        }
    }


}
