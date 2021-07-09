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
        name = "Vehiculos",
        uniqueConstraints = {
                @UniqueConstraint(name = "U_vehiculo_placa", columnNames = { "vehiculoPlaca" })
        }

)
public class Vehiculos implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "vehiculo_generadorz")
    @SequenceGenerator(name = "vehiculo_generador", sequenceName = "vehiculos_secuencia", initialValue = 1,allocationSize = 1)
    @Column(name = "vehiculo_id", nullable = false, updatable = false)
    private Long vehiculoId;
    @ManyToOne
    @JoinColumn(name ="contratista_id",referencedColumnName = "contratista_id",foreignKey = @ForeignKey(name = "FK_vehiculo_contratista"),updatable = false)
    private Contratistas contratista;
    @ManyToOne
    @JoinColumn(name ="ruta_id",referencedColumnName = "ruta_id",foreignKey = @ForeignKey(name = "FK_vehiculo_ruta"))
    private Rutas ruta;
    @ManyToOne
    @JoinColumn(name ="tipo_id",referencedColumnName = "tipo_id",foreignKey = @ForeignKey(name = "FK_vehiculo_tipo"))
    private TiposVehiculos tipo;
    @Column(nullable = false,updatable = false)
    private String  vehiculoMarca;
    @Column(nullable = false,updatable = false)
    private String  vehiculoPlaca;
    @Column(nullable = false,updatable = false)
    private double  vehiculoPeso;
    @Column(nullable = false,updatable = false)
    private String  vehiculoModelo;
    @Column(nullable = false,updatable = false)
    private Date vehiculoFechaCreacion;
    @Column(nullable = false,updatable = true)
    private int vehiculoEstado;




    private Date newDate(){
        return new Date();
    }



    @PrePersist
    void createdAt() {

        this.vehiculoFechaCreacion = newDate();


    }


}
