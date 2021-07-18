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
public class CeldasAdmitenDesechos implements Serializable {

    //Entidad cuya clave primaria es una tupla, por esta razón se especifica que su id es embedido
    @EmbeddedId
    private CeldasAdmitenDesechosId celdasAdmitenDesechosId;
}
