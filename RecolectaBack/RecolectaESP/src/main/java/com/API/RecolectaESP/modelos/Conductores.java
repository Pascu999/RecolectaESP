package com.API.RecolectaESP.modelos;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Cacheable(false)
public class Conductores {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "conductores_id")
    @Column(name = "conductor_id", nullable = false, updatable = false)
    private Long conductorId;
    @ManyToOne
    @JoinColumn(name ="contratista_id",referencedColumnName = "contratista_id",foreignKey = @ForeignKey(name = "FK_conductor_contrista"))
    private Contratistas contratista;
    @Column(nullable = false,updatable = true)
    private String conductorNombre;
    @Column(nullable = false,updatable = true)
    private String conductorApellido;
    @Column(nullable = false,updatable = true)
    private String conductorDocumento;
    @Column(nullable = false,updatable = true)
    private Date conductorFechaNacimiento;
    @Column(nullable = false,updatable = true)
    private String conductorCelular;
    @Column(nullable = false,updatable = true)
    private String conductorCorreo;
    @Column(nullable = false,updatable = true)
    private int conductorEstado;
}
