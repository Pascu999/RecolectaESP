package com.API.RecolectaESP.controladores;


import com.API.RecolectaESP.modelos.Trabajadores;
import com.API.RecolectaESP.servicios.TrabajadoresServicio;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/Trabajadores")
@Api(description = "Controlador para acceder a los servicios de los trabajadores")
public class TrabajadoresControlador {

    private final TrabajadoresServicio trabajadoresServicio;

    public TrabajadoresControlador(TrabajadoresServicio trabajadoresServicio){
        this.trabajadoresServicio = trabajadoresServicio;
    }

    //Loggin a partir del nit del documento y su contraseña
    @GetMapping("/SolicitudLoggin/{trabajador_documento}/{trabajador_contrasena}")
    public ResponseEntity<Trabajadores> SolicitudLoggin(

            @ApiParam(
                    value = "Documento ingresado por el trabajador",
                    example = "11111",
                    required = true
            )
            @PathVariable ("trabajador_documento") String trabajador_documento,
            @ApiParam(
                    value = "Contrasena ingresada por el trabajador",
                    example = "1111fgd1",
                    required = true
            )
            @PathVariable ("trabajador_contrasena") String trabajador_contrasena
    ){
        System.out.println("XD");
        Trabajadores trabajador = trabajadoresServicio.SolicitudLoggin(trabajador_documento,trabajador_contrasena);
        return  new ResponseEntity<>(trabajador, HttpStatus.OK);
    }



}
