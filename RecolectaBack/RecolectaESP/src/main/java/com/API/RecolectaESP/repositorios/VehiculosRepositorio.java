package com.API.RecolectaESP.repositorios;


import com.API.RecolectaESP.modelos.Facturas;
import com.API.RecolectaESP.modelos.Vehiculos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface VehiculosRepositorio extends JpaRepository<Vehiculos,Long> {

    @Transactional
    public Optional<Vehiculos> findVehiculosByVehiculoPlaca(String Placa);

    @Transactional(readOnly = true)
    @Query("FROM Vehiculos vehiculo WHERE vehiculo.contratista.contratistaId = :contratista_id ORDER BY vehiculo.vehiculoFechaCreacion DESC")
    public List<Vehiculos> findVehiculosByContratistaId(@Param("contratista_id") Long contratista_id);


    @Transactional
    @Modifying(clearAutomatically = true,flushAutomatically = true)
    @Query(value = "UPDATE VEHICULOS set vehiculo_estado = CASE  when vehiculo_estado = 0  THEN 1 when vehiculo_estado = 1 THEN 0 END WHERE vehiculo_id= :vehiculo_id" ,nativeQuery = true)
    public void cambiarEstadoVehiculo(@Param("vehiculo_id") Long vehiculo_id);
}

