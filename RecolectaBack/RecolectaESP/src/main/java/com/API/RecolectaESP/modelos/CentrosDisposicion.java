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
public class CentrosDisposicion implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "centros_disposicion_id")
    @Column(name = "centro_disposicion_id", nullable = false, updatable = false)
    private Long centroDisposicionId;
    @ManyToOne
    @JoinColumn(name ="municipio_id",referencedColumnName = "municipio_id",foreignKey = @ForeignKey(name = "FK_centro_disposicion_municipio"))
    private Municipios municipio;
    @Column(updatable = false,nullable = false)
    private String centroDisposicionNombre;
    @Column(updatable = false,nullable = false)
    private String centroDisposicionDireccion;
    @Column(updatable = false,nullable = true)
    private String centroDisposicionCelular;
    @Column(updatable = false,nullable = true)
    private String centroDisposicionCorreo;
    @Column(updatable = false,nullable = true)
    private int centroDisposicionEstado;

}
