package com.API.RecolectaESP.servicios;

import com.API.RecolectaESP.excepciones.TrabajadorContrasenaIncorrectaExcepcion;
import com.API.RecolectaESP.excepciones.TrabajadorNoEncontradoExcepcion;
import com.API.RecolectaESP.modelos.Trabajadores;
import com.API.RecolectaESP.repositorios.TrabajadoresRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TrabajadoresServicio {

    private final TrabajadoresRepositorio trabajadoresRepositorio;

    @Autowired

    public TrabajadoresServicio(TrabajadoresRepositorio trabajadoresRepositorio){
        this.trabajadoresRepositorio = trabajadoresRepositorio;
    }

    public Trabajadores SolicitudLoggin(String Documento, String contraseña){
        Trabajadores respuestTrabajador = trabajadoresRepositorio.findTrabajadoresByTrabajadorDocumento(Documento)
                .orElseThrow(() -> new TrabajadorNoEncontradoExcepcion("No se encontró contratista con el NIT especificado" ));

        if(respuestTrabajador.getTrabajadorContrasena().equals(contraseña) ){
            return respuestTrabajador;
        }
        else{
            throw new TrabajadorContrasenaIncorrectaExcepcion("Contraseña incorrecta");
        }
    }
}
