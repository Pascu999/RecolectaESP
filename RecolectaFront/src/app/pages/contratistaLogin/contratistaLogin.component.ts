import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, OnDestroy, NgModule } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { Contratista } from 'src/app/models/contratista';
import { ContratistaLoginService } from 'src/app/services/contratistaLogin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-contratistaLogin',
  templateUrl: './contratistaLogin.component.html',
  styleUrls: ['./contratistaLogin.component.scss']
})

@NgModule({
  imports: [FormsModule, BrowserModule],
  exports: []
})


export class ContratistaLoginComponent implements OnInit {


  constructor(private router: Router, private loginContratistasServicio: ContratistaLoginService) { }
  private contratista_nit: String;//Nit del contratista que ingresa
  private contratista_contrasena: String;//Contraseña del contratista que ingresa


  ngOnInit() {

    localStorage.clear();
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

    //Se verifica que no haya un trabajador o un contratista loggeados
    if (localStorage.getItem("contratista_id") == null && localStorage.getItem("trabajador_id") != null) {
      this.router.navigateByUrl("/Trabajadores")
    }
    else if (localStorage.getItem("contratista_id") != null) {
      this.router.navigateByUrl("/Contratistas")
    }

  }

  public onLoginContratista(formularioLoggin: NgForm) {
    this.loginContratistasServicio.solicitudLogginContratista(this.contratista_nit, this.contratista_contrasena).subscribe(
      (response: Contratista) => {
        Swal.fire({
          title: '¡Bienvenido, Contratista!',
          icon: 'success',
          confirmButtonText: 'Aceptar',
          width: '20%',
          backdrop: false,
          timer: 3000,
          toast: true,
          position: 'top-end'
        })
        
        //Se almacena el id del contratista que se loggeó
        localStorage.setItem("contratista_id", response.contratistaId.toString());
        this.router.navigateByUrl("/Contratistas")

      }
      ,
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
