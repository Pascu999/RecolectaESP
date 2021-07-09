package com.API.RecolectaESP.servicios;

import com.API.RecolectaESP.modelos.Rutas;
import com.API.RecolectaESP.repositorios.RutasRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RutasServicio {
    private final RutasRepositorio rutasRepositorio;

    @Autowired
    public RutasServicio(RutasRepositorio rutasRepositorio){
        this.rutasRepositorio = rutasRepositorio;
    }

    public List<Rutas> obtenerRutasMunicipio(Long municipio_id){
        return rutasRepositorio.findRutasByMunicipioId(municipio_id);
    }
}
