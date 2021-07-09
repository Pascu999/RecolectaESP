package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Rutas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import java.util.List;
import java.util.Optional;

public interface RutasRepositorio extends JpaRepository<Rutas,Long> {

    @Query("FROM Rutas ruta WHERE ruta.municipio.municipioId = :municipio_id")
    public List<Rutas> findRutasByMunicipioId(Long municipio_id);
}
