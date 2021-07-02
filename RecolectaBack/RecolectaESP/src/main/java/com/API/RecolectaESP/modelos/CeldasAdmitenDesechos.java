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
public class CeldasAdmitenDesechos implements Serializable {
    @EmbeddedId
    private CeldasAdmitenDesechosId celdasAdmitenDesechosId;
}
