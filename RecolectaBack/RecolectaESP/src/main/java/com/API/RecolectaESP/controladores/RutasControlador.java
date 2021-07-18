package com.API.RecolectaESP.controladores;

import com.API.RecolectaESP.modelos.Rutas;
import com.API.RecolectaESP.servicios.RutasServicio;
import io.swagger.annotations.Api;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/Rutas")
@Api(description = "Controlador para acceder a los servicios de las rutas")
public class RutasControlador {

    private final RutasServicio rutasServicio;

    public RutasControlador (RutasServicio rutasServicio){
        this.rutasServicio = rutasServicio;
    }

    //Se obtienen las rutas relacionadas con un municipio
    @GetMapping("/obtenerRutas/{municipio_id}")
    public ResponseEntity<List<Rutas>> obtenerRutasMunicipio(@PathVariable Long municipio_id){
        List<Rutas> rutasMunicipio = rutasServicio.obtenerRutasMunicipio(municipio_id);
        return new ResponseEntity<>(rutasMunicipio, HttpStatus.OK);
    }
}
