package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Trabajadores;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TrabajadoresRepositorio extends JpaRepository<Trabajadores, Long> {

    public Optional<Trabajadores> findTrabajadoresByTrabajadorDocumento(String Documento);

}