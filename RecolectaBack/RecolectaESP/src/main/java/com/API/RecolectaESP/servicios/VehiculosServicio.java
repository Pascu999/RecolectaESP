package com.API.RecolectaESP.servicios;


import com.API.RecolectaESP.excepciones.VehiculoNoEncontradoExcepcion;
import com.API.RecolectaESP.excepciones.VehiculoNoExisteExcepcion;
import com.API.RecolectaESP.modelos.TiposVehiculos;
import com.API.RecolectaESP.modelos.Vehiculos;
import com.API.RecolectaESP.repositorios.TiposVehiculosRepositorio;
import com.API.RecolectaESP.repositorios.VehiculosRepositorio;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VehiculosServicio {

    @Autowired private final VehiculosRepositorio vehiculosRepositorio;

    @Autowired private final TiposVehiculosRepositorio tiposVehiculosRepositorio;

    @Autowired
    public VehiculosServicio(VehiculosRepositorio vehiculosRepositorio,TiposVehiculosRepositorio tiposVehiculosRepositorio){
        this.vehiculosRepositorio = vehiculosRepositorio;
        this.tiposVehiculosRepositorio = tiposVehiculosRepositorio;
    }

    public Vehiculos consultarVehiculo(String Placa){
        return vehiculosRepositorio.findVehiculosByVehiculoPlaca(Placa)
                .orElseThrow(() -> new VehiculoNoEncontradoExcepcion("No se encontró vehiculo con la placa especificada" ));
    }

    public List<Vehiculos> obtenerVehiculosContratista(Long contratista_id){
        return  vehiculosRepositorio.findVehiculosByContratistaId(contratista_id);
    }

    public List<TiposVehiculos> otenerTiposVehiculos(){
        return tiposVehiculosRepositorio.findAll();
    }


    public Vehiculos registrarVehiculo(Vehiculos vehiculo){
        return vehiculosRepositorio.save(vehiculo);
    }

    public void cambiarEstadoVehiculo(Long vehiculo_id) {
        System.out.println(vehiculo_id);
        vehiculosRepositorio.cambiarEstadoVehiculo(vehiculo_id);

    }

    public Vehiculos actualizarVehiculo(Vehiculos vehiculoActualizado, Long vehiculo_id){

        Vehiculos vehiculoBuscar = vehiculosRepositorio.findById(vehiculo_id)
                .orElseThrow(()->new VehiculoNoExisteExcepcion("No se puede editar este vehiculo"));

        if(vehiculoBuscar != null){
            return   vehiculosRepositorio.save(vehiculoActualizado);
        }
        else throw new VehiculoNoExisteExcepcion("No se puede editar este vehiculo");

    }

}
