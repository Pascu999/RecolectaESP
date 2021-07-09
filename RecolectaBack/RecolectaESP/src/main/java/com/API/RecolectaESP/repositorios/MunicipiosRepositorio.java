package com.API.RecolectaESP.repositorios;

import com.API.RecolectaESP.modelos.Municipios;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface MunicipiosRepositorio extends JpaRepository<Municipios,Long> {


}
