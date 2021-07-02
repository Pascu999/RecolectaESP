package com.API.RecolectaESP.excepciones;

public class TrabajadorContrasenaIncorrectaExcepcion extends RuntimeException{
    public TrabajadorContrasenaIncorrectaExcepcion(String mensaje) {
        super(mensaje);
    }
}
