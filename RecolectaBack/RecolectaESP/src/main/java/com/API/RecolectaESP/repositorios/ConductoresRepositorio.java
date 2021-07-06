package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Conductores;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Optional;

public interface ConductoresRepositorio extends JpaRepository<Conductores,Long> {



    @Transactional
    public Optional<Conductores>  findConductoresByConductorDocumento(String Documento);
}
