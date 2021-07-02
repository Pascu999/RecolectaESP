package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
public class TiposVehiculos {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tipos_secuencia")
    @Column(name = "tipo_id", nullable = false, updatable = false)
    private Long tipoId;
    @Column(nullable = false,updatable = true)
    private String tipoNombre;
    @Column(nullable = false,updatable = true)
    private String tipoDescripcion;
}
