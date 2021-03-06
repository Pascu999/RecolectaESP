import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit} from '@angular/core';
import { Router } from '@angular/router';
import { Trabajador } from 'src/app/models/trabajador';
import { LoginTrabajadoresService } from 'src/app/services/loginTrabajadores.service';
import Swal from 'sweetalert2';


@Component({
  selector: 'app-trabajadorLogin',
  templateUrl: './trabajadorLogin.component.html',
  styleUrls: ['./trabajadorLogin.component.scss']
})

export class TrabajadorLoginComponent implements OnInit {
  constructor(private loginTrabajadoresServicio: LoginTrabajadoresService, private router: Router) { }

  private trabajador_documento: String;//Documento del trabajador que ingresa
  private trabajador_contrasena: String;//Contraseña del trabajador que ingresa




  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

    //Se verifica que no haya un trabajador o un contratista loggeados
    if (Number(localStorage.getItem("trabajador_tipo")) == 1) {
      this.router.navigateByUrl("/Administradores")
    }
    else if (Number(localStorage.getItem("trabajador_tipo")) == 2) {
      this.router.navigateByUrl("/Trabajadores")
    }
    else if (localStorage.getItem("contratista_id") != null) {
      this.router.navigateByUrl("/Contratistas")
    }

  }
  ngOnDestroy() {
  }

  public onLoginTrabajador(): void {


    //Loggin
    this.loginTrabajadoresServicio.SolicitudLogginTrabajador(this.trabajador_documento, this.trabajador_contrasena).subscribe(
      (response: Trabajador) => {
        //Se guarda la información del trabajador y el centro de disposicion al que pertenece
        localStorage.setItem("trabajador_id", response.trabajadorId.toString());
        localStorage.setItem("centro_disposicion_id", response.centroDisposicion.centroDisposicionId.toString());
        localStorage.setItem("trabajador_tipo", response.trabajadorTipo.toString());
        if (Number(localStorage.getItem("trabajador_tipo")) == 1) {
          this.router.navigateByUrl("/Administradores")
          Swal.fire({
            title: '¡Bienvenido, Administrador!',
            icon: 'success',
            confirmButtonText: 'Aceptar',
            width: '20%',
            backdrop: false,
            timer: 3000,
            toast: true,
            position: 'top-end'
          })

        }
        else if (Number(localStorage.getItem("trabajador_tipo")) == 2) {
          this.router.navigateByUrl("/Trabajadores")
          Swal.fire({
            title: '¡Bienvenido, Operador!',
            icon: 'success',
            confirmButtonText: 'Aceptar',
            width: '20%',
            backdrop: false,
            timer: 3000,
            toast: true,
            position: 'top-end'
          })
        }

      },
      (error: HttpErrorResponse) => {
        if (error.status == 500) {
          Swal.fire({
            title: 'No se pudo iniciar sesión',
            text: 'información de ingreso incorrecta',
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
