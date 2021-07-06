package com.API.RecolectaESP.repositorios;


import com.API.RecolectaESP.modelos.Vehiculos;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Optional;

public interface VehiculosRepositorio extends JpaRepository<Vehiculos,Long> {

    @Transactional
    public Optional<Vehiculos> findVehiculosByVehiculoPlaca(String Placa);
}
