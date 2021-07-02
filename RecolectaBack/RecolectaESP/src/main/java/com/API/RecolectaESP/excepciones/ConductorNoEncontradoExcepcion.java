package com.API.RecolectaESP.excepciones;

public class ConductorNoEncontradoExcepcion extends RuntimeException{
    public ConductorNoEncontradoExcepcion(String mensaje) {
        super(mensaje);
    }
}
