package com.API.RecolectaESP.controladores;

import com.API.RecolectaESP.modelos.Municipios;
import com.API.RecolectaESP.repositorios.MunicipiosRepositorio;
import com.API.RecolectaESP.servicios.MunicipiosServicio;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/Municipios")
@Api(description = "Controlador para acceder a los servicios de los municipios")
public class MunicipiosControlador {

    private final MunicipiosServicio municipiosServicio;

    @Autowired
    public MunicipiosControlador (MunicipiosServicio municipiosServicio){
        this.municipiosServicio = municipiosServicio;
    }

    @RequestMapping("/obtener")
    public ResponseEntity<List<Municipios>> obtenerMunicipio(){
        List<Municipios> listaMunicipios = municipiosServicio.obtenerMunicipios();
        return new ResponseEntity<>(listaMunicipios, HttpStatus.OK);
    }


}
