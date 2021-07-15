package com.API.RecolectaESP.modelos;


import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Cacheable(false)
@Table(
        name = "Facturas",
        indexes = {
                @Index(name = "IDX_Facturas_Contratista",columnList = "contratista_id"),
                @Index(name = "IDX_Facturas_Centro_Disposicion",columnList = "centro_disposicion_id"),
                @Index(name = "IDX_Facturas_Rango_Fecha",columnList = "facturaInicioPeriodo DESC,facturaFinPeriodo DESC")
        }
)
public class Facturas implements Serializable {
    @Id
    @Column(name = "factura_id", nullable = false, updatable = false)
    private Long facturaId;
    @ManyToOne
    @JoinColumn(name ="contratista_id",referencedColumnName = "contratista_id",foreignKey = @ForeignKey(name = "FK_factura_contratista"),nullable = false)
    private Contratistas contratista;
    @ManyToOne
    @JoinColumn(name ="centro_disposicion_id",referencedColumnName = "centro_disposicion_id",foreignKey = @ForeignKey(name = "FK_factura_centro"),nullable = false)
    private CentrosDisposicion centroDisposicion;
    @Column(nullable = false,updatable = false)
    private Date facturaInicioPeriodo;
    @Column(nullable = false,updatable = false)
    private Date facturaFinPeriodo;
    @Column(nullable = false,updatable = true)
    private double facturaDescuento;
    @Column(nullable = false,updatable = true)
    private double facturaCostoTransporte;


}

