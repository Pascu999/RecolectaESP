package com.API.RecolectaESP.servicios;



import com.API.RecolectaESP.excepciones.IngresoNoRealizadoExcepcion;
import com.API.RecolectaESP.modelos.Ingresos;
import com.API.RecolectaESP.repositorios.IngresosRepositorio;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.List;

@Service
public class IngresosServicio {

    private final IngresosRepositorio ingresosRepositorio;


    @Autowired
    public IngresosServicio(IngresosRepositorio ingresosRepositorio){
        this.ingresosRepositorio = ingresosRepositorio;
    }

    public List<Ingresos> obtenerIngresosFactura(Long factura_id){

        return  ingresosRepositorio.findIngresosByFacturaId(factura_id);
    }


    public static String crearIngreso(ObjectNode ingreso) throws SQLException, ClassNotFoundException {
        String nuevoIngreso = IngresosRepositorio.crearIngreso(ingreso);



        if(nuevoIngreso == null){
            throw new IngresoNoRealizadoExcepcion("No se pudo realizar el ingreso" );
        }
        else{
            return nuevoIngreso;
        }
    }
}


