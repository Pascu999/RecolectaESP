package com.API.RecolectaESP.modelos;

import javax.persistence.Embeddable;
import javax.persistence.ForeignKey;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
public final class CeldasAdmitenDesechosId implements Serializable {
    //La tupla (celda,desecho) forma la llave primaria de esta entidad
    @ManyToOne
    @JoinColumn(name = "celda_id",referencedColumnName = "celda_id",foreignKey = @ForeignKey(name = "FK_celda_admitiendo"))
    private Celdas celda;
    @ManyToOne
    @JoinColumn(name = "desecho_id",referencedColumnName = "desecho_id",foreignKey = @ForeignKey(name = "FK_celda_admite_desecho"))
    private Desechos desecho;

}