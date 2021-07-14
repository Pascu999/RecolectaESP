import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, OnDestroy, NgModule } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { Contratista } from 'src/app/models/contratista';
import { LoginContratistasServicio } from 'src/app/services/loginContratistas.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-loginContratista',
  templateUrl: './loginContratista.component.html',
  styleUrls: ['./loginContratista.component.scss']
})

@NgModule({
  imports:[FormsModule,BrowserModule],
  exports:[]
})


export class LoginContratistaComponent implements OnInit, OnDestroy {
  constructor(private router: Router, private loginContratistasServicio : LoginContratistasServicio) {}

  contratista_nit: String;
  contratista_contrasena: String;

  public contratista: Contratista;

  
  ngOnInit() {

    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

    if(localStorage.getItem("contratista_id") == null && localStorage.getItem("trabajador_id") != null){
      this.router.navigateByUrl("/Trabajadores")
    }
    else if(localStorage.getItem("contratista_id") != null){
      this.router.navigateByUrl("/Contratistas")
    }

  }
  ngOnDestroy() {
  }

  public onLoginContratista(formularioLoggin: NgForm){
    this.loginContratistasServicio.SolicitudLogginContratista(this.contratista_nit,this.contratista_contrasena).subscribe(
      (response: Contratista)=>{
        Swal.fire({
          title: '¡Bienvenido, Contratista!',
          icon: 'success',
          confirmButtonText: 'Aceptar',
          width: '20%',
          backdrop: false,
          timer: 3000,
          toast: true,
          position:'top-end'
        })
        this.contratista = response;
        console.log(response);
        localStorage.setItem("contratista_id",response.contratistaId.toString());
        
    console.log(localStorage.getItem("ultima_facturacion"));

        this.router.navigateByUrl("/Contratistas")
        
      }
      ,
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
