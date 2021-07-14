import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, OnDestroy, NgModule } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { Trabajador } from 'src/app/models/trabajador';
import { LoginTrabajadoresService } from 'src/app/services/loginTrabajadores.service';
import Swal from 'sweetalert2';


@Component({
  selector: 'app-loginTrabajador',
  templateUrl: './loginTrabajador.component.html',
  styleUrls: ['./loginTrabajador.component.scss']
})

@NgModule({
  imports:[FormsModule,BrowserModule],
  exports:[]
})
export class LoginTrabajadorComponent implements OnInit, OnDestroy {
  constructor(private loginTrabajadoresServicio: LoginTrabajadoresService, public router: Router) {}

  trabajador_documento: String;
  trabajador_contrasena: String;

  public trabajador: Trabajador;


 
  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");
    
    if(Number(localStorage.getItem("trabajador_tipo")) == 1){
      this.router.navigateByUrl("/Administradores")
    }
    if(localStorage.getItem("contratista_id") != null){
      this.router.navigateByUrl("/Contratistas")
    }
    else if(Number(localStorage.getItem("trabajador_tipo")) == 2){
      this.router.navigateByUrl("/Trabajadores")
    }
  }
  ngOnDestroy() {
  }

  public onLoginTrabajador(formularioLoggin: NgForm):void{
    
    this.loginTrabajadoresServicio.SolicitudLogginTrabajador(this.trabajador_documento,this.trabajador_contrasena).subscribe(
      ( response : Trabajador) => {
        this.trabajador = response;
        console.log(response);
        localStorage.setItem("trabajador_id",response.trabajadorId.toString());
        localStorage.setItem("centro_disposicion_id",response.centroDisposicion.centroDisposicionId.toString());
        localStorage.setItem("trabajador_tipo",response.trabajadorTipo.toString());
        if(Number(localStorage.getItem("trabajador_tipo")) == 1){
          this.router.navigateByUrl("/Administradores")
          Swal.fire({
            title: '¡Bienvenido, Administrador!',
            icon: 'success',
            confirmButtonText: 'Aceptar',
            width: '20%',
            backdrop: false,
            timer: 3000,
            toast: true,
            position:'top-end'
          })
          
        }
        else if(Number(localStorage.getItem("trabajador_tipo")) == 2){
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
        
      } ,
      (error: HttpErrorResponse) => {
        if(error.status == 500){
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
            position:'center'
          })

        }
      }
    )

  }

}
