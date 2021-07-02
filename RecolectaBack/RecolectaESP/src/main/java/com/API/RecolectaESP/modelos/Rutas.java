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
public class Rutas implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rutas_secuencia")
    @Column(name = "ruta_id", nullable = false, updatable = false)
    private Long rutaId;
    @ManyToOne
    @JoinColumn(name ="municipio_id",referencedColumnName = "municipio_id",foreignKey = @ForeignKey(name = "FK_ruta_municipio"))
    private Municipios municipio;
    @Column(nullable = false,updatable = true)
    private String rutaNombre;
    @Column(nullable = false,updatable = false)
    private String rutaDescripcion;
    @Column(nullable = false, updatable = false)
    private Date  rutaFechaInicio;
    @Column(nullable = false, updatable = false)
    private Date  rutaFechaFinalizacion;
    @Column(nullable = false,updatable = false)
    private int rutaEstado;




    private Date newDate(){
        return new Date();
    }



    @PrePersist
    void createdAt() {

        this.rutaFechaInicio = newDate();


    }


}
