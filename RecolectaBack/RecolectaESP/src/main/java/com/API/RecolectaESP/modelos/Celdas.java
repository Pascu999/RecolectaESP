package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Cacheable(false)
public class Celdas {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "celdas_secuencia")
    @Column(name = "celda_id", nullable = false, updatable = false)
    private Long celdaId;
    @ManyToOne
    @JoinColumn(name ="centro_disposicion_id",referencedColumnName = "centro_disposicion_id",foreignKey = @ForeignKey(name = "FK_celda_centro"))
    private CentrosDisposicion centroDisposicion;
    @Column(nullable = false,updatable = false)
    private String celdaNombre;
    @Column(nullable = false,updatable = false)
    private int celdaCapacidadTotal;
    @Column(nullable = false,updatable = true)
    private int celdaCapacidadUsada;
    @Column(nullable = false,updatable = true)
    private int celdaEstado;
}