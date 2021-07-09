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
        name = "Contratistas",
        uniqueConstraints = {
                @UniqueConstraint(name = "U_contratista_NIT", columnNames = { "contratistaNit" }),
                @UniqueConstraint(name = "U_contratista_Celular", columnNames = { "contratistaCelular" }),
                @UniqueConstraint(name = "U_contratista_Correo", columnNames = { "contratistaCelular" }),
        }

)
public class Contratistas implements Serializable {


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "contratistas_secuencia")
    @Column(name = "contratista_id", nullable = false, updatable = false)
    private Long contratistaId;
    @Column(nullable = false)
    private String contratistaNit;
    @Column(nullable = false)
    private String contratistaNombre;
    @Column(nullable = false)
    private String contratistaCelular;
    @Column(nullable = false)
    private String contratistaDireccion;
    @Column(nullable = false)
    private String contratistaCorreo;
    @Column(nullable = false)
    private String contratistaContrasena;
    @Column(nullable = false, updatable = false)
    private Date  contratistaFechaCreacion;
    @Column(nullable = true,updatable = false)
    private Date contratistaUltimaFacturacion;


    @PrePersist
    void createdAt() {
        this.contratistaFechaCreacion = new Date();
    }

}
