import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginContratistaComponent } from '../../pages/loginContratistas/loginContratista.component';
import { AutenticacionRoutingModule } from './autenticacion-routing.module';
import { LoginTrabajadorComponent } from '../../pages/loginTrabajadores/loginTrabajador.component';



@NgModule({
  declarations: [
    LoginContratistaComponent,
    LoginTrabajadorComponent],
  imports: [
    CommonModule,
    AutenticacionRoutingModule
  ]
})
export class AutenticacionModule { }