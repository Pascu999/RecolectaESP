package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Municipios;
import com.API.RecolectaESP.modelos.Rutas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface MunicipiosRepositorio extends JpaRepository<Municipios,Long> {

    @Transactional
    @Query(value = "select * from municipios where municipio_id IN (select municipio_id FROM rutas) AND municipio_estado = 1",nativeQuery = true)
    public List<Municipios> findMunicipios();



}
