package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
public class Municipios {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "municipios_secuencia")
    @Column(name = "municipio_id", nullable = false, updatable = false)
    private Long municipioId;
    @Column(nullable = false,updatable = true)
    private String municipioNombre;
    @Column(nullable = false,updatable = true)
    private String municipioCodigoPostal;
    @Column(nullable = false,updatable = true)
    private int municipioEstado;
}
