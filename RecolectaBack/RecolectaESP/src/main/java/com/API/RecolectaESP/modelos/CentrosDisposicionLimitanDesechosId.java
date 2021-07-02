package com.API.RecolectaESP.modelos;

import javax.persistence.Embeddable;
import javax.persistence.ForeignKey;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
public final class CentrosDisposicionLimitanDesechosId implements Serializable {
    @ManyToOne
    @JoinColumn(name = "centro_disposicion_id",referencedColumnName = "centro_disposicion_id",foreignKey = @ForeignKey(name = "FK_centro_disposicion_limitando"))
    private CentrosDisposicion centroDisposicion;
    @ManyToOne
    @JoinColumn(name = "desecho_id",referencedColumnName = "desecho_id",foreignKey = @ForeignKey(name = "FK_desecho_limitado"))
    private Desechos desecho;
    @ManyToOne
    @JoinColumn(name = "tipo_id",referencedColumnName = "tipo_id",foreignKey = @ForeignKey(name = "FK_vehiculo_limitado"))
    private TiposVehiculos tipo;



}