import { Component, NgModule, OnInit } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { Celda } from 'src/app/modelos/celda';
import { Conductor } from 'src/app/modelos/conductor';
import { GeneracionIngreso, Ingreso } from 'src/app/modelos/ingreso';
import { Vehiculo } from 'src/app/modelos/vehiculo';
import { IngresosServicio } from '../../servicios/ingresos.Service';

@Component({
  selector: 'app-ingresos',
  templateUrl: './ingresos.component.html',
  styleUrls: ['./ingresos.component.scss']
})


export class IngresosComponente implements OnInit {

  ngOnInit(
  ) {
  }
  
  vehiculo_placa: String;
  conductor_documento: String;
  
  private obtenerFecha(): String {
    fecha: String;
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = String(today.getFullYear());

    return mm + '/' + dd + '/' + yyyy;

  }


  private nuevoIngreso: GeneracionIngreso = {
    ingreso_peso: null,
    conductor_id: null,
    desecho_id: null,
    trabajador_id: null,
    contratista_id: null,
    vehiculo_id: null,
    centro_disposicion_id: null,
    ingreso_fecha: this.obtenerFecha()
  }




  public ingreso: Ingreso;
  public vehiculos: Vehiculo[];
  constructor(private ingresoServicio: IngresosServicio) { }


  public onCrearIngreso(formularioIngreso: NgForm): void {


    var conductor_contratista: Number;
    var vehiculo_contratista: Number;
    var vehiculoIngresado: Vehiculo;
    var conductorIngresado: Conductor;

    
    this.ingresoServicio.obtenerVehiculo(this.vehiculo_placa).subscribe(
      (response: Vehiculo) => {
        vehiculoIngresado = response;
        conductor_contratista = response.contratista.contratistaId
        this.ingresoServicio.obtenerConductor(this.conductor_documento).subscribe(


          (response: Conductor) => {
            conductorIngresado = response;
            vehiculo_contratista = response.contratista.contratistaId

            if(conductor_contratista == vehiculo_contratista){
              localStorage.setItem("trabajador_id",'1');
              localStorage.setItem("centro_disposicion_id",'1');
              this.nuevoIngreso.desecho_id = Number(this.nuevoIngreso.desecho_id);
              this.nuevoIngreso.contratista_id = conductor_contratista;
              this.nuevoIngreso.vehiculo_id = vehiculoIngresado.vehiculoId;
              this.nuevoIngreso.conductor_id = conductorIngresado.conductorId;
              this.nuevoIngreso.trabajador_id = Number(localStorage.getItem("trabajador_id"));
              this.nuevoIngreso.centro_disposicion_id = Number(localStorage.getItem("centro_disposicion_id"));
              console.log('coincidendcia');
              console.log(this.nuevoIngreso);
              
              this.ingresoServicio.crearIngreso(this.nuevoIngreso).subscribe(
                (response: Celda)=>{
                  console.log(response);
                  
                }
              )
            }
            else{
              
              console.log("Conductor y/o contratistas invalidos");
              
            }
            
          }
        )
      }
    )










  }







}