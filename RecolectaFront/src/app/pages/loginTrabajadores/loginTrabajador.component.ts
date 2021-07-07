import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, OnDestroy, NgModule } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { Trabajador } from 'src/app/models/trabajador';
import { LoginTrabajadoresService } from 'src/app/services/loginTrabajadores.service';

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
    else if(Number(localStorage.getItem("trabajador_tipo")) == 2){
      this.router.navigateByUrl("/Trabajadores")
    }
  }
  ngOnDestroy() {
  }

  public onLoginTrabajador(formularioLoggin: NgForm):void{
    this.loginTrabajadoresServicio.SolicitudLoggin(this.trabajador_documento,this.trabajador_contrasena).subscribe(
      ( response : Trabajador) => {
        this.trabajador = response;
        console.log(response);
        localStorage.setItem("trabajador_id",response.trabajadorId.toString());
        localStorage.setItem("centro_disposicion_id",response.centroDisposicion.centroDisposicionId.toString());
        localStorage.setItem("trabajador_tipo",response.centroDisposicion.centroDisposicionId.toString());
        if(Number(localStorage.getItem("trabajador_tipo")) == 1){
          this.router.navigateByUrl("/Administradores")
        }
        else if(Number(localStorage.getItem("trabajador_tipo")) == 2){
          this.router.navigateByUrl("/Trabajadores")
        }
        
      } ,
      (error: HttpErrorResponse) => {
        alert(error.message);
        console.log(error.message);
      }
    );

  }

}
