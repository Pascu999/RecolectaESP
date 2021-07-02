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
@Table(
        name = "Ingresos",
        indexes = {
                @Index(name = "IDX_Ingresos_Fecha", columnList = "ingresoFecha DESC"),
                @Index(name = "IDX_Ingresos_Factura", columnList = "factura_id"),
                @Index(name = "IDX_Ingresos_Vehiculo", columnList = "vehiculo_id")
        }

)
public class Ingresos implements Serializable {
    @Id
    @Column(name = "ingreso_id", updatable = false)
    private Long ingresoId;
    @ManyToOne
    @JoinColumn(name ="vehiculo_id",referencedColumnName = "vehiculo_id",foreignKey = @ForeignKey(name = "FK_ingreso_vehiculo"),updatable = false)
    private Vehiculos vehiculo;
    @ManyToOne
    @JoinColumn(name ="conductor_id",referencedColumnName = "conductor_id",foreignKey = @ForeignKey(name = "FK_ingreso_conductor"),updatable = false)
    private Conductores conductor;
    @ManyToOne
    @JoinColumn(name ="desecho_id",referencedColumnName = "desecho_id",foreignKey = @ForeignKey(name = "FK_ingreso_desecho"), updatable=false)
    private Desechos desecho;
    @ManyToOne
    @JoinColumn(name ="trabajador_id",referencedColumnName = "trabajador_id",foreignKey = @ForeignKey(name = "FK_ingreso_trabajador"),updatable = false)
    private Trabajadores trabajador;
    @ManyToOne
    @JoinColumn(name ="celda_id",referencedColumnName = "celda_id",foreignKey = @ForeignKey(name = "FK_ingreso_celda"))
    private Celdas celda;
    @ManyToOne
    @JoinColumn(name ="factura_id",referencedColumnName = "factura_id",foreignKey = @ForeignKey(name = "FK_ingreso_factura"))
    private Facturas factura;
    @Column(nullable = false,updatable = false)
    private double ingresoPeso;
    @Column(nullable = true,updatable = false)
    private int ingresoValorTransporte;
    @Column(nullable = true,updatable = true)
    private double ingresoPesoSobrecarga;
    @Column(nullable = true,updatable = true)
    private int ingresoValorSobrecarga;
    @Column(nullable = false,updatable = false)
    private Date ingresoFecha;
    @Column(nullable = true,updatable = false)
    private int ingresoEstado;

    //private Date newDate(){
    //    return new Date();
    //}



    @PrePersist
    void createdAt() {

        //this.ingresoFecha = newDate();


    }
}

