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
public class ContratistasTarifanDesechos implements Serializable {
    @EmbeddedId
    private ContratistasTarifanDesechosId contratistasTarifanDesechosId;
    @Column(nullable = false,updatable = false)
    private double contratistasTarifanDesechosPrecioKilo;
}