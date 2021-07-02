package com.API.RecolectaESP.repositorios;


import com.API.RecolectaESP.modelos.Vehiculos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VehiculosRepositorio extends JpaRepository<Vehiculos,Long> {
    public Optional<Vehiculos> findVehiculosByVehiculoPlaca(String Placa);
}
