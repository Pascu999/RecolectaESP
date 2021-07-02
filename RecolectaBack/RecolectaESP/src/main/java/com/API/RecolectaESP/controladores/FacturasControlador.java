package com.API.RecolectaESP.controladores;

import com.API.RecolectaESP.modelos.Facturas;
import com.API.RecolectaESP.servicios.FacturasServicio;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.util.List;


@Api(description = "Controlador para acceder a los servicios de las facturas")
@RestController
@RequestMapping("/Facturas")
public class FacturasControlador {

    private final FacturasServicio facturasServicio;

    public FacturasControlador(FacturasServicio facturasServicio){
        this.facturasServicio = facturasServicio;
    }

    @GetMapping("/obtenerFacturasContratista/{contratista_id}")
    public ResponseEntity<List<Facturas>> obtenerFacturasContratista(
            @ApiParam(
                    value = "Id del contratista al que se le obtienen sus facturas",
                    example = "1",
                    required = true
            )
            @PathVariable ("contratista_id") Long contratista_id
    ){
        List<Facturas> listaFacturas = facturasServicio.obtenerFacturasContratista(contratista_id);
        return new ResponseEntity<>(listaFacturas,HttpStatus.OK);
    }

    @GetMapping("/GenerarFacturas/{contratista_id}")
    public ResponseEntity<ObjectNode> generarFacturas(
            @ApiParam(

                    value = "Id del contratista al que se le generan sus facturas",
                    example = "1",
                    required = true
            )
            @PathVariable ("contratista_id") Long contratista_id
    ){
        ObjectNode resultadoGeneracion = null;
        return new ResponseEntity<>(resultadoGeneracion,HttpStatus.OK);
    }


}
