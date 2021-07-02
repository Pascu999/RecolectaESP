package com.API.RecolectaESP.excepciones;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(
        value = HttpStatus.BAD_REQUEST,
        reason = "No se pudo realizar el ingreso"
)
public class IngresoFallidoExcepcionExcepcion extends RuntimeException{
    public IngresoFallidoExcepcionExcepcion(String mensaje){
        super(mensaje);

        System.out.println("XD");
    }
}
