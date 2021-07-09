package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.TiposVehiculos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TiposVehiculosRepositorio extends JpaRepository<TiposVehiculos,Long> {

}
