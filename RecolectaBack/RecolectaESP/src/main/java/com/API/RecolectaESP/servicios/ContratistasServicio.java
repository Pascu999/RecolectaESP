package com.API.RecolectaESP.servicios;

import com.API.RecolectaESP.excepciones.ContratistaContrasenaIncorrectaExcepcion;
import com.API.RecolectaESP.excepciones.ContratistaNoEncontradoExcepcion;
import com.API.RecolectaESP.modelos.Contratistas;
import com.API.RecolectaESP.repositorios.ContratistasRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service
public class ContratistasServicio {

    private final ContratistasRepositorio contratistasRepositorio;


    @Autowired
    public ContratistasServicio(ContratistasRepositorio contratistasRepositorio){
        this.contratistasRepositorio = contratistasRepositorio;
    }

    //Retorna la información del contratista si sus datos de ingreso son correctos, en caso de que no sea así se genera un error dependiendo del caso
    public Contratistas SolicitudLoggin(String NIT,String contraseña){
        Contratistas respuestaContratista = contratistasRepositorio.findContratistasByContratistaNit(NIT)
                .orElseThrow(() -> new ContratistaNoEncontradoExcepcion("No se encontró contratista con el NIT especificado" ));

        if(respuestaContratista.getContratistaContrasena().equals(contraseña) ){
            return respuestaContratista;
        }
        else{
            throw new ContratistaContrasenaIncorrectaExcepcion("Contraseña incorrecta");
        }
    }

    //Retorna la fecha de la ultima facturación realizada a un contratista
    public String ultimaFacturacion(Long contratista_id){
        Contratistas obtenerContratista = contratistasRepositorio.findById(contratista_id)
                .orElseThrow(() -> new ContratistaNoEncontradoExcepcion("No se encontró contratista con el NIT especificado" ));
        return obtenerContratista.getContratistaUltimaFacturacion().toString();
    }
}
