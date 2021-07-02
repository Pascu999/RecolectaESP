package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Contratistas;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface ContratistasRepositorio extends JpaRepository<Contratistas, Long> {

    public Optional<Contratistas> findContratistasByContratistaNit(String NIT);



}