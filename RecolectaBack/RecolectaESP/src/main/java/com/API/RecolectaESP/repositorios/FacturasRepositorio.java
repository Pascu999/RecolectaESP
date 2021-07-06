package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Facturas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface FacturasRepositorio extends JpaRepository<Facturas,Long> {

    @Transactional(readOnly=true)
    @Query("FROM Facturas factura WHERE factura.contratista.contratistaId = :contratista_id")
    public List<Facturas> findFacturasByContratistaId(@Param("contratista_id") Long contratista_id);

    @Transactional(readOnly=true)
    @Query("FROM Facturas factura WHERE factura.centroDiposicion.centroDisposicionId = :centro_disposicion_id")
    public List<Facturas> findFacturasByCentroDisposionId(@Param("centro_disposicion_id") Long centro_disposicion_id);

    @Transactional(readOnly=true)
    public Facturas findFacturasByFacturaId(Long factura_id);


}
