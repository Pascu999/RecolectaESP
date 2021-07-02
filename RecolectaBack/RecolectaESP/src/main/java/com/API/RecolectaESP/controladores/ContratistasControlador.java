package com.API.RecolectaESP.controladores;

import com.API.RecolectaESP.modelos.Contratistas;
import com.API.RecolectaESP.servicios.ContratistasServicio;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@Api(description = "Controlador para acceder a los servicios de los contrastistas")
@RestController
@RequestMapping("/Contratistas")

public class ContratistasControlador {

    private final ContratistasServicio contratistasServicio;

    public ContratistasControlador(ContratistasServicio contratistasServicio) {this.contratistasServicio = contratistasServicio;}


    @PutMapping(value = "/SolicitudLoggin/{trabajador_nit}/{trabajador_contrasena}",consumes = "application/json", produces = "application/json")

    public ResponseEntity<Contratistas> SolicitudLoggin(
            @ApiParam(
                    value = "NIT ingresado por el contratista",
                    example = "11111",
                    required = true
            )
            @PathVariable ("trabajador_nit") String trabajador_nit,
            @ApiParam(
                    value = "Contrasena ingresada por el contratista",
                    example = "1111fgd1",
                    required = true
            )
            @PathVariable ("trabajador_contrasena") String Contrasena
            )

    {

        Contratistas contratista = contratistasServicio.SolicitudLoggin(trabajador_nit,Contrasena);
        return  new ResponseEntity<>(contratista, HttpStatus.OK);
    }




}
