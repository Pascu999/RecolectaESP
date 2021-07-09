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
@Table(
        name = "Trabajadores",
        uniqueConstraints = {
                @UniqueConstraint(name = "U_Trabajador_Documento", columnNames = { "trabajadorDocumento" }),
                @UniqueConstraint(name = "U_Trabajador_Celular", columnNames = { "trabajadorCelular" }),
                @UniqueConstraint(name = "U_Trabajador_Correo", columnNames = { "trabajadorCorreo" }),
        }

)
public class Trabajadores {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "trabajadores_secuencia")
    @Column(name = "trabajador_id", nullable = false, updatable = false)
    private Long trabajadorId;
    @ManyToOne
    @JoinColumn(name ="centro_disposicion_id",referencedColumnName = "centro_disposicion_id",foreignKey = @ForeignKey(name = "FK_trabajador_centro"))
    private CentrosDisposicion centroDisposicion;
    @Column(nullable = false,updatable = true)
    private String trabajadorNombre;
    @Column(nullable = false,updatable = true)
    private String trabajadorApellido;
    @Column(nullable = false,updatable = true)
    private String trabajadorDocumento;
    @Column(nullable = false,updatable = true)
    private String trabajadorCelular;
    @Column(nullable = false,updatable = true)
    private String trabajadorCorreo;
    @Column(nullable = false,updatable = true)
    private String trabajadorDireccion;
    @Column(nullable = false,updatable = true)
    private int trabajadorTipo;
    @Column(nullable = false,updatable = true)
    private Date trabajadorFechaIngreso;
    @Column(nullable = false,updatable = true)
    private Date trabajadorFechaNacimiento;
    @Column(nullable = false,updatable = true)
    private String trabajadorContrasena;
    @Column(nullable = false,updatable = true)
    private int trabajadorEstado;

    private Date newDate(){
        return new Date();
    }



    @PrePersist
    void createdAt() {

        this.trabajadorFechaIngreso = newDate();


    }
}
