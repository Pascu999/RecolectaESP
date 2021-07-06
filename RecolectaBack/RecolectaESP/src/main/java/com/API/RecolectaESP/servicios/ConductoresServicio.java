package com.API.RecolectaESP.servicios;

import com.API.RecolectaESP.excepciones.VehiculoNoEncontradoExcepcion;
import com.API.RecolectaESP.modelos.Conductores;
import com.API.RecolectaESP.modelos.Vehiculos;
import com.API.RecolectaESP.repositorios.ConductoresRepositorio;
import com.API.RecolectaESP.repositorios.VehiculosRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConductoresServicio {

    private final ConductoresRepositorio conductoresRepositorio;

    @Autowired
    public ConductoresServicio(ConductoresRepositorio conductoresRepositorio){
        this.conductoresRepositorio = conductoresRepositorio;
    }

    public Conductores consultarConductor(String Documento){
        System.out.println("//////////////////////////");
        System.out.println(Documento);
        return conductoresRepositorio.findConductoresByConductorDocumento(Documento)
                .orElseThrow(() -> new VehiculoNoEncontradoExcepcion("No se encontró un conductor con el documento especificado" ));
    }
}