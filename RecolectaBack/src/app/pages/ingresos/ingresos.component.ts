import { Component, NgModule, OnInit } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { Celda } from 'src/app/modelos/celda';
import { GeneracionIngreso, Ingreso } from 'src/app/modelos/ingreso';
import { IngresosServicio } from 'src/app/servicios/ingresos.Service';

@Component({
  selector: 'app-ingresos',
  templateUrl: './ingresos.component.html',
  styleUrls: ['./ingresos.component.scss']
})


export class IngresosComponente implements OnInit {

  private obtenerFecha(): String {
    fecha : String;
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = String(today.getFullYear());

    return mm + '/' + dd + '/' + yyyy;

  }




  ngOnInit(
  ) {


  }

  private nuevoIngreso: GeneracionIngreso = {
    ingreso_peso : null,
    conductor_id : null,
    desecho_id : null,
    trabajador_id : null,
    contratista_id : null,
    vehiculo_id : null,
    tipo_id : null,
    centro_disposicion_id : Number(localStorage.getItem("centro_disposicion_id")),
    ingreso_fecha : this.obtenerFecha()
  }




  public ingreso: Ingreso;
  constructor(private ingresoServicio: IngresosServicio) { }


  public onCrearIngreso(formularioIngreso: NgForm): void {

    this.ingresoServicio.crearIngreso(this.nuevoIngreso).subscribe(
      (response: Celda) => {
        console.log(response.celda_id);

      }
    )

  }




}