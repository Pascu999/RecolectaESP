package com.API.RecolectaESP.servicios;

import com.API.RecolectaESP.modelos.Municipios;
import com.API.RecolectaESP.repositorios.MunicipiosRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MunicipiosServicio {


    private final MunicipiosRepositorio municipiosRepositorio;

    @Autowired
    public MunicipiosServicio(MunicipiosRepositorio municipiosRepositorio){
        this.municipiosRepositorio = municipiosRepositorio;
    }


    public List<Municipios> obtenerMunicipios(){
        return municipiosRepositorio.findAll();
    }
}
