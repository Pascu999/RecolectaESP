import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginContratistaComponent } from '../../pages/loginContratistas/loginContratista.component';
import { LoginTrabajadorComponent } from '../../pages/loginTrabajadores/loginTrabajador.component';



@NgModule({
  declarations: [
    LoginContratistaComponent,
    LoginTrabajadorComponent],
  imports: [
    CommonModule,
    AutenticacionModule
  ]
})
export class AutenticacionModule { }
