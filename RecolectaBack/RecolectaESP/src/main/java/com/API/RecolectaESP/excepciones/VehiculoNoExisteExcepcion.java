package com.API.RecolectaESP.excepciones;

public class VehiculoNoExisteExcepcion extends RuntimeException {
    public VehiculoNoExisteExcepcion(String mensaje) {

        super(mensaje);
    }
}