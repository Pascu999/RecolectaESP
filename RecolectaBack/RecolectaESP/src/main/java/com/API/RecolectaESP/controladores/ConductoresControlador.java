package com.API.RecolectaESP.controladores;


import com.API.RecolectaESP.modelos.Conductores;
import com.API.RecolectaESP.servicios.ConductoresServicio;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Api(description = "Controlador para acceder a los servicios  de los conductores")
@RestController
@RequestMapping("/Conductores")
public class ConductoresControlador {
    private final ConductoresServicio conductoresServicio;
    public ConductoresControlador(ConductoresServicio conductoresServicio){
        this.conductoresServicio = conductoresServicio;
    }

    //Obtener conductor en base a su documento de identificacion
    @GetMapping("/Consultar/{conductor_documento}")
    public ResponseEntity<Conductores> consultarConductor(
            @ApiParam(

                    value = "Documento del conductor al que se le va a consultar su información",
                    example = "1",
                    required = true
            )
            @PathVariable ("conductor_documento") String conductor_documento
    ){


        Conductores conductorConsultado = conductoresServicio.consultarConductor(conductor_documento);
        return new ResponseEntity<>(conductorConsultado,HttpStatus.OK);
    }

}
