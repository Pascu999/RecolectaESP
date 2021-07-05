package com.API.RecolectaESP.servicios;


import com.API.RecolectaESP.excepciones.VehiculoNoEncontradoExcepcion;
import com.API.RecolectaESP.modelos.Vehiculos;
import com.API.RecolectaESP.repositorios.VehiculosRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VehiculosServicio {

    private final VehiculosRepositorio vehiculosRepositorio;

    @Autowired
    public VehiculosServicio(VehiculosRepositorio vehiculosRepositorio){
        this.vehiculosRepositorio = vehiculosRepositorio;
    }

    public Vehiculos consultarVehiculo(String Placa){
        return vehiculosRepositorio.findVehiculosByVehiculoPlaca(Placa)
                .orElseThrow(() -> new VehiculoNoEncontradoExcepcion("No se encontró vehiculo con la placa especificada" ));
    }
}