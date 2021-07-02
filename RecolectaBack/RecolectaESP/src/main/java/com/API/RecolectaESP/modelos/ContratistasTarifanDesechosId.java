package com.API.RecolectaESP.modelos;

import javax.persistence.Embeddable;
import javax.persistence.ForeignKey;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
public final class ContratistasTarifanDesechosId implements Serializable {
    @ManyToOne
    @JoinColumn(name = "contratista_id",referencedColumnName = "contratista_id",foreignKey = @ForeignKey(name = "FK_Contratista_tarifa_Desecho"))
    private Contratistas contratista;
    @ManyToOne
    @JoinColumn(name = "desecho_id",referencedColumnName = "desecho_id",foreignKey = @ForeignKey(name = "FK_Desecho_tarifado"))
    private Desechos desecho;

}