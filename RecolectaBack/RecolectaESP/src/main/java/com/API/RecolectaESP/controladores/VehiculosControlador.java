package com.API.RecolectaESP.controladores;


import com.API.RecolectaESP.modelos.Vehiculos;
import com.API.RecolectaESP.servicios.VehiculosServicio;
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

    @Autowired private final VehiculosServicio vehiculosServicio;

    public VehiculosControlador(VehiculosServicio vehiculosServicio){
        this.vehiculosServicio = vehiculosServicio;
    }

    @DeleteMapping("/CambiarEstado/{vehiculo_id}")
    public ResponseEntity<Vehiculos> cambiarEstadoVehiculo(
            @ApiParam(

                    value = "Id del vehiculo que se va a desactivar",
                    example = "1",
                    required = true
            )
            @PathVariable ("vehiculo_id") String vehiculo_id
    ){
        Vehiculos vehiculoCambio = null;

        return new ResponseEntity<>(vehiculoCambio,HttpStatus.OK);
    }


    @GetMapping("/Consultar/{vehiculo_placa}")
    public ResponseEntity<Vehiculos> consultarVehiculo(
            @ApiParam(

                    value = "Placa del vehiculo al que se le va a consultar su información",
                    example = "1",
                    required = true
            )
            @PathVariable ("vehiculo_placa") String vehiculo_placa
    ){
        System.out.println(vehiculo_placa);
        Vehiculos vehiculoConsultado = vehiculosServicio.consultarVehiculo(vehiculo_placa);
        System.out.println(vehiculoConsultado);

        return new ResponseEntity<>(vehiculoConsultado,HttpStatus.OK);
    }

    @PutMapping("/Actualizar/{vehiculo_id}")
    public ResponseEntity<Vehiculos> actualizarVehiculo(
            @ApiParam(

                    value = "Id del vehiculo al que se le va a actualizar su información",
                    example = "1",
                    required = true
            )
            @PathVariable ("vehiculo_id") String vehiculo_id
    ){
        Vehiculos vehiculoEditado = null;
        return new ResponseEntity<>(vehiculoEditado, HttpStatus.OK);
    }

    @GetMapping("/Listar/{contratista_id}")
    public ResponseEntity<List<Vehiculos>> obtenerVehiculosContratista(
            @ApiParam(

                    value = "Id del contratista al que se le van a listar sus vehiculos",
                    example = "1",
                    required = true
            )
            @PathVariable ("contratista_id") String contratista_id
    ){
        List<Vehiculos> listadoVehiculos = null;

        return new ResponseEntity<>(listadoVehiculos,HttpStatus.OK);

    }

    @PostMapping("/Crear")
    public ResponseEntity<Vehiculos> registrarVehiculo(
            @ApiParam(

                    value = "Valores del nuevo vehiculo",
                    example = "Vehiculo{}",
                    required = true
            )
            @RequestBody Vehiculos vehiculo
    ){
        Vehiculos nuevoVehiculo = null;
        return new ResponseEntity<>(nuevoVehiculo, HttpStatus.OK);
    }
}
