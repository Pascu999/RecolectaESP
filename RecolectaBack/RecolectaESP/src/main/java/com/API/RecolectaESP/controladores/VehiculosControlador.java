package com.API.RecolectaESP.controladores;


import com.API.RecolectaESP.modelos.TiposVehiculos;
import com.API.RecolectaESP.modelos.Vehiculos;
import com.API.RecolectaESP.servicios.VehiculosServicio;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Api(description = "Controlador para acceder a los servicios     de los vehiculos")
@RestController
@RequestMapping("/Vehiculos")
public class VehiculosControlador {

    private final VehiculosServicio vehiculosServicio;


    @Autowired
    public VehiculosControlador(VehiculosServicio vehiculosServicio){
        this.vehiculosServicio = vehiculosServicio;
    }

    //Consultar información de un vehículo a partir de su placa
    @GetMapping("/Consultar/{vehiculo_placa}")
    public ResponseEntity<Vehiculos> consultarVehiculo(
            @ApiParam(

                    value = "Placa del vehiculo al que se le va a consultar su información",
                    example = "1",
                    required = true
            )
            @PathVariable ("vehiculo_placa") String vehiculo_placa

    ){
        Vehiculos vehiculoConsultado = vehiculosServicio.consultarVehiculo(vehiculo_placa);

        return new ResponseEntity<>(vehiculoConsultado,HttpStatus.OK);
    }

    //Actualizar un vehículo
    @PutMapping("/Actualizar/{vehiculo_id}")
    public ResponseEntity<Vehiculos> actualizarVehiculo(

            @ApiParam(

                    value = "Id del vehiculo al que se le va a actualizar su información",
                    example = "1",
                    required = true
            )
            @PathVariable ("vehiculo_id") Long vehiculo_id,
            @ApiParam(

                    value = "Valores nuevos del  vehiculo",
                    example = "Vehiculo{}",
                    required = true
            )
            @RequestBody Vehiculos vehiculo
    ){
        Vehiculos vehiculoEditado = vehiculosServicio.actualizarVehiculo(vehiculo,vehiculo_id);
        return new ResponseEntity<>(vehiculoEditado, HttpStatus.OK);
    }

    //Listar vehículos asociados a un contratista
    @GetMapping("/Listar/{contratista_id}")
    public ResponseEntity<List<Vehiculos>> obtenerVehiculosContratista(
            @ApiParam(

                    value = "Id del contratista al que se le van a listar sus vehiculos",
                    example = "1",
                    required = true
            )
            @PathVariable ("contratista_id") Long contratista_id
    ){
        List<Vehiculos> listadoVehiculos = vehiculosServicio.obtenerVehiculosContratista(contratista_id);

        return new ResponseEntity<>(listadoVehiculos,HttpStatus.OK);

    }

    //Obtener tipos de vehículos
    @GetMapping("/Tipos/buscar")
    public ResponseEntity<List<TiposVehiculos>> obtenerTiposVehiculos(
    ){
        List<TiposVehiculos> listadoTipos = vehiculosServicio.otenerTiposVehiculos();
        return new ResponseEntity<>(listadoTipos,HttpStatus.OK);

    }

    //Crear un vehículo
    @PostMapping("/Crear")
    public ResponseEntity<Vehiculos> registrarVehiculo(
            @ApiParam(

                    value = "Valores del nuevo vehiculo",
                    example = "Vehiculo{}",
                    required = true
            )
            @RequestBody Vehiculos vehiculo
    ){
        Vehiculos nuevoVehiculo = vehiculosServicio.registrarVehiculo(vehiculo);
        return new ResponseEntity<>(nuevoVehiculo, HttpStatus.OK);
    }
}
