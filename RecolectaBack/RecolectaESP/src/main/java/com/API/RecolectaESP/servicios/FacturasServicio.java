package com.API.RecolectaESP.servicios;


import com.API.RecolectaESP.modelos.Facturas;
import com.API.RecolectaESP.repositorios.FacturasRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FacturasServicio {

    private final FacturasRepositorio facturasRepositorio;


    @Autowired
    public FacturasServicio(FacturasRepositorio facturasRepositorio){
        this.facturasRepositorio = facturasRepositorio;
    }

    public List<Facturas> obtenerFacturasContratista(Long factura_id){

        return   facturasRepositorio.findFacturasByContratistaId(factura_id);
    }
}
