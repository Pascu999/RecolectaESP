package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Cacheable(false)

public class CentrosDisposicionLimitanDesechos implements Serializable {
    //Entidad con una llave primaria formada  por una tupla, por lo que su id es embedido
    @EmbeddedId
    private CentrosDisposicionLimitanDesechosId centrosDisposicionLimitanDesechosiD;
    @Column(nullable = false,updatable = false)
    private int centrosDisposicionLimitanDesechosPesoMaximo;
    @Column(nullable = false,updatable = false)
    private int centrosDisposicionLimitanDesechosCostoExceso;
}