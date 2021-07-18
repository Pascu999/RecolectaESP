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


import java.sql.SQLException;
import java.util.List;


@Api(description = "Controlador para acceder a los servicios de las facturas")
@RestController
@RequestMapping("/Facturas")
public class FacturasControlador {

    private final FacturasServicio facturasServicio;

    public FacturasControlador(FacturasServicio facturasServicio){
        this.facturasServicio = facturasServicio;
    }

    //Se obtienen las facturas de un contratista a partir de su id
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

    //Se obtienen las facturas de un centro a partir de su id
    @GetMapping("/obtenerFacturasCentro/{centro_disposicion_id}")
    public ResponseEntity<List<Facturas>> obtenerFacturasCentro(
            @ApiParam(
                    value = "Id del Centro al que se le obtienen sus facturas",
                    example = "1",
                    required = true
            )
            @PathVariable ("centro_disposicion_id") Long centro_disposicion_id
    ){
        List<Facturas> listaFacturas = facturasServicio.obtenerFacturasCentro(centro_disposicion_id);
        return new ResponseEntity<>(listaFacturas,HttpStatus.OK);
    }

    //Se obtiene la información de una factura a partir de su id
    @GetMapping("/ObtenerFactura/{factura_id}")
    public ResponseEntity<Facturas> obtenerFactura(
            @ApiParam(

                    value = "Id de la factura a consultar",
                    example = "1",
                    required = true
            )
            @PathVariable ("factura_id") Long factura_id
    ){
        Facturas facturaEncontrada = facturasServicio.obtenerFactura(factura_id);
        return new ResponseEntity<>(facturaEncontrada,HttpStatus.OK);
    }
    //Llamado al proceso masivo
    @GetMapping("/GenerarFacturas")
    public ResponseEntity<HttpStatus> generarFacturas() throws SQLException, ClassNotFoundException {
    	System.out.println("FACTURANDO");
        facturasServicio.generarFacturas();
        return new ResponseEntity<>(HttpStatus.OK);
    }



}
