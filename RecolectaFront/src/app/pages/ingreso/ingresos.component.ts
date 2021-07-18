import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { Conductor } from 'src/app/models/conductor';
import { GeneracionIngreso } from 'src/app/models/ingreso';
import { Vehiculo } from 'src/app/models/vehiculo';
import { IngresosService } from '../../services/ingreso.service';
import Swal from 'sweetalert2';
import { HttpErrorResponse } from '@angular/common/http';


@Component({
  selector: 'app-ingresos',
  templateUrl: './ingresos.component.html',
  styleUrls: ['./ingresos.component.scss']
})


export class IngresoComponent implements OnInit {



  private vehiculo_placa: string;//Placa del vehículo que ingresa
  private conductor_documento: string;//Documento del conductor que ingresa
  private nuevoIngreso: GeneracionIngreso = {
    ingreso_peso: null,
    conductor_id: null,
    desecho_id: null,
    trabajador_id: null,
    contratista_id: null,
    vehiculo_id: null,
    centro_disposicion_id: null
  }//Datos del ingreso que se va a generar



  ngOnInit() {

    //Se verifica que al acceder a la ruta se encuentre el trabajador loggeado 
    if (localStorage.getItem("contratista_id") == null && localStorage.getItem("trabajador_id") == null) {
      this.router.navigateByUrl("/LoginTrabajador")
    }
    else if (localStorage.getItem("contratista_id") != null) {
      this.router.navigateByUrl("/Contratistas")
    }
  }


  constructor(private ingresoServicio: IngresosService, private router: Router) { }


  //Se crea el ingreso
  public onCrearIngreso(): void {


    var conductor_contratista: number;
    var vehiculo_contratista: number;
    var vehiculoIngresado: Vehiculo;
    var conductorIngresado: Conductor;



    //Validacion del formato de placa ingresado
    if (!(/^[A-Z][A-Z][A-Z][-][0-9][0-9][0-9]/.test(this.vehiculo_placa))) {
      Swal.fire({
        title: 'Formato de placa no valido',
        text: 'La placa del vehiculo debe tener tres letras mayusculas, seguidas de un guion y tres numeros',
        icon: 'error',
        confirmButtonText: 'Aceptar',
        width: '20%',
        backdrop: false,
        timer: 8000,
        toast: true,
        position: 'top-end'
      })
    }

    //Vehículo que ingresa
    else {
      this.ingresoServicio.obtenerVehiculo(this.vehiculo_placa).subscribe(


        (response: Vehiculo) => {
          vehiculoIngresado = response;
          vehiculo_contratista = vehiculoIngresado.contratista.contratistaId
          this.nuevoIngreso.ingreso_peso = this.nuevoIngreso.ingreso_peso - vehiculoIngresado.vehiculoPeso//El peso del ingreso es el peso digitado menos el peso del vehículo

          //Se verifica que tanto el vehículo como la ruta se encuentren activos
          if (vehiculoIngresado.vehiculoEstado == 0 || vehiculoIngresado.ruta.rutaEstado == 0) {
            Swal.fire({
              title: 'Vehículo no autorizado',
              text: 'El vehículo que intenta ingresar y/o la ruta que recorre se encuentran inactivos',
              icon: 'error',
              confirmButtonText: 'Aceptar',
              width: '30%',
              padding: '1rem',
              heightAuto: true,
              backdrop: true,
              timer: 3000,
              position: 'center'
            })
          }
          //Se verifica que el peso ingresado corresponda a los limites establecidos
          else if (this.nuevoIngreso.ingreso_peso < 200 || this.nuevoIngreso.ingreso_peso > 1000) {
            Swal.fire({
              title: 'Peso invalido',
              text: 'El peso ingresado debe estar entre 200 y 1000 kilos (sin incluir el peso del vehículo)',
              icon: 'error',
              confirmButtonText: 'Aceptar',
              width: '20%',
              backdrop: false,
              timer: 3000,
              toast: true,
              position: 'top-end'
            })
          }
          else {
            //Conductor ingresado
            this.ingresoServicio.obtenerConductor(this.conductor_documento).subscribe(
              (response: Conductor) => {
                conductorIngresado = response;
                conductor_contratista = conductorIngresado.conductorId

                //Se comprueba que tanto el conductor como el vehículo pertenezcan al mismo contratista
                if (conductor_contratista == vehiculo_contratista) {

                  //Datos del ingreso
                  this.nuevoIngreso.desecho_id = Number(this.nuevoIngreso.desecho_id);
                  this.nuevoIngreso.contratista_id = conductor_contratista;
                  this.nuevoIngreso.vehiculo_id = vehiculoIngresado.vehiculoId;
                  this.nuevoIngreso.conductor_id = conductorIngresado.conductorId;
                  this.nuevoIngreso.trabajador_id = Number(localStorage.getItem("trabajador_id"));
                  this.nuevoIngreso.centro_disposicion_id = Number(localStorage.getItem("centro_disposicion_id"));

                  //Se crea el ingreso
                  this.ingresoServicio.crearIngreso(this.nuevoIngreso).subscribe(
                    (response: String) => {
                      this.router.navigateByUrl("/Trabajadores/instruccionIngreso/" + response)
                      Swal.fire({
                        title: '¡Ingreso Exitoso!',
                        icon: 'success',
                        confirmButtonText: 'Aceptar',
                        width: '20%',
                        backdrop: false,
                        timer: 3000,
                        toast: true,
                        position: 'top-end'
                      })
                    },
                    (error: HttpErrorResponse) => {
                      if (error.status == 500) {
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
                          position: 'center'
                        })

                      }
                    }


                  )
                }
                else {
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
                    position: 'center'
                  })
                }

              },
              (error: HttpErrorResponse) => {
                if (error.status == 500) {
                  Swal.fire({
                    title: 'No se pudo realizar el ingreso',
                    text: 'no existe un registro del conductor ingresado',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    width: '30%',
                    padding: '1rem',
                    heightAuto: true,
                    backdrop: true,
                    timer: 3000,
                    position: 'center'
                  })

                }
              }

            )
          }
        },
        (error: HttpErrorResponse) => {
          if (error.status == 500) {
            Swal.fire({
              title: 'No se pudo realizar el ingreso',
              text: 'no existe un registro del vehiculo ingresado',
              icon: 'error',
              confirmButtonText: 'Aceptar',
              width: '30%',
              padding: '1rem',
              heightAuto: true,
              backdrop: true,
              timer: 3000,
              position: 'center'
            })

          }
        }
      )

    }

  }
}