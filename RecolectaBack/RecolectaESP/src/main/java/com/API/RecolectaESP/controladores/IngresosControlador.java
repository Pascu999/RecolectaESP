package com.API.RecolectaESP.controladores;


import com.API.RecolectaESP.Proyecciones.IngresosProyeccion;
import com.API.RecolectaESP.servicios.IngresosServicio;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;


@Api(description = "Controlador para acceder a los servicios de los Ingresos")
@RestController
@RequestMapping("/Ingresos")
public class IngresosControlador {
    private final IngresosServicio ingresosServicio;

    public IngresosControlador(IngresosServicio ingresosServicio) {this.ingresosServicio = ingresosServicio;}

    //Ingresos relacionados a una factura a partir de su id
    @GetMapping("/obtenerIngresosFactura/{factura_id}")
    public ResponseEntity<List<IngresosProyeccion>> obtenerIngresosFactura(
            @ApiParam(

                    value = "Id de la factura a la que se le van a obtener sus respectivos ingresos",
                    example = "1",
                    required = true
            )
            @PathVariable ("factura_id") Long factura_id
    ){
        List<IngresosProyeccion> listaIngresos = ingresosServicio.obtenerIngresosFactura (factura_id);
        return new ResponseEntity<>(listaIngresos, HttpStatus.OK);
    }

    //Crear un nuevo ingreso
    @PostMapping(value = "/Crear")
    public ResponseEntity<String> crearIngreso(
            @ApiParam(

                    value = "Valores del nuevo ingreso",
                    example = "Ingreso{}",
                    required = true
            )
            @RequestBody ObjectNode ingreso
    ) throws SQLException, ClassNotFoundException {

            String nuevoIngreso = IngresosServicio.crearIngreso(ingreso);
            return new ResponseEntity<>(nuevoIngreso, HttpStatus.OK);

    }
}
