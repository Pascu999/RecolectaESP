import { Component, NgModule, OnInit } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { Conductor } from 'src/app/models/conductor';
import { GeneracionIngreso, Ingreso } from 'src/app/models/ingreso';
import { Vehiculo } from 'src/app/models/vehiculo';
import { IngresosServicio } from '../../services/ingresos.Service';
import Swal from 'sweetalert2';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-ingresos',
  templateUrl: './ingresos.component.html',
  styleUrls: ['./ingresos.component.scss']
})


export class IngresosComponente implements OnInit {

  ngOnInit(
  ) {
    if(localStorage.getItem("contratista_id") == null && localStorage.getItem("trabajador_id") == null){
      this.router.navigateByUrl("/LoginTrabajador")
    }
    else if(localStorage.getItem("contratista_id") != null){
      this.router.navigateByUrl("/Contratistas")
    }
  }

  vehiculo_placa: String;
  conductor_documento: String;

  private obtenerFecha(): String {
    fecha: String;
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = String(today.getFullYear());

    return  dd + '/' + mm  + '/' + yyyy;

  }


  nuevoIngreso: GeneracionIngreso = {
    ingreso_peso: null,
    conductor_id: null,
    desecho_id: null,
    trabajador_id: null,
    contratista_id: null,
    vehiculo_id: null,
    centro_disposicion_id: null
  }




  public ingreso: Ingreso;
  public vehiculos: Vehiculo[];
  constructor(private ingresoServicio: IngresosServicio, private router: Router) { }


  public onCrearIngreso(formularioIngreso: NgForm): void {


    var conductor_contratista: Number;
    var vehiculo_contratista: Number;
    var vehiculoIngresado: Vehiculo;
    var conductorIngresado: Conductor;

    console.log(this.vehiculo_placa);
    console.log(this.conductor_documento);
    
    this.ingresoServicio.obtenerVehiculo(this.vehiculo_placa).subscribe(


      (response: Vehiculo) => {
        vehiculoIngresado = response;
        conductor_contratista = vehiculoIngresado.contratista.contratistaId
        this.ingresoServicio.obtenerConductor(this.conductor_documento).subscribe(
          (response: Conductor) => {
            conductorIngresado = response;

            vehiculo_contratista = conductorIngresado.contratista.contratistaId

            if (conductor_contratista == vehiculo_contratista) {

              this.nuevoIngreso.desecho_id = Number(this.nuevoIngreso.desecho_id);
              this.nuevoIngreso.contratista_id = conductor_contratista;
              this.nuevoIngreso.vehiculo_id = vehiculoIngresado.vehiculoId;
              this.nuevoIngreso.conductor_id = conductorIngresado.conductorId;
              this.nuevoIngreso.trabajador_id = Number(localStorage.getItem("trabajador_id"));
              this.nuevoIngreso.centro_disposicion_id = Number(localStorage.getItem("centro_disposicion_id"));
              console.log(this.nuevoIngreso);
              console.log('SIN ERROR');

              this.ingresoServicio.crearIngreso(this.nuevoIngreso).subscribe(
                (response: String) => {
                  localStorage.setItem("celda_nombre", String(response))
                  console.log(response);
                  this.router .navigateByUrl("/Trabajadores/instruccionIngreso")
                  Swal.fire({
                    title: '¡Ingreso Exitoso!',
                    icon: 'success',
                    confirmButtonText: 'Aceptar',
                    width: '20%',
                    backdrop: false,
                    timer: 3000,
                    toast: true,
                    position:'top-end'
                  })
                },
                (error: HttpErrorResponse) => {
                  if(error.status == 500){
                    Swal.fire({
                      title: 'No se pudo realizar el ingreso',
                      text: 'no existe una celda que pueda admitir el ingreso',
                      icon: 'error',
                      confirmButtonText: 'Aceptar',
                      width: '30%',
                      padding: '1rem',
                      heightAuto: true,
                      backdrop: true,
                      timer: 3000,
                      position:'center'
                    })
          
                  }
                }
          

              )
            }
            else {
              console.log("Conductor y/o contratistas invalidos");
              Swal.fire({
                title: 'No se pudo realizar el ingreso',
                text: 'inconsistencia entre el vehiculo y el conductor que ingresa',
                icon: 'warning',
                confirmButtonText: 'Aceptar',
                width: '30%',
                padding: '1rem',
                heightAuto: true,
                backdrop: true,
                timer: 3000,
                position:'center'
              })
            }

          }
        )
      }
    )
  }
}