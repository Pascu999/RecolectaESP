package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
public class Desechos {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "desechos_secuencia")
    @Column(name = "desecho_id", nullable = false, updatable = false)
    private Long desechoId;
    @Column(nullable = false,updatable = false)
    private String desechoNombre;
    @Column(nullable = false,updatable = false)
    private String desechoDescripcion;
    @Column(nullable = false,updatable = true)
    private int desechoEstado;
}
