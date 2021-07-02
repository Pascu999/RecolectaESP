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

public class CentrosDisposicionLimitanDesechos implements Serializable {
    @EmbeddedId
    private CentrosDisposicionLimitanDesechosId centrosDisposicionLimitanDesechosiD;
    @Column(nullable = false,updatable = false)
    private int centrosDisposicionLimitanDesechosPesoMaximo;
    @Column(nullable = false,updatable = false)
    private int centrosDisposicionLimitanDesechosCostoExceso;
}