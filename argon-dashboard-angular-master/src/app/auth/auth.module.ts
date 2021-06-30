import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginContratistaComponent } from './pages/loginContratistas/loginContratista.component';
import { LoginTrabajadorComponent } from './pages/loginTrabajadores/loginTrabajador.component';
import { AuthRoutingModule } from './auth-routing.module';



@NgModule({
  declarations: [
    LoginContratistaComponent,
    LoginTrabajadorComponent],
  imports: [
    CommonModule,
    AuthRoutingModule
  ]
})
export class AuthModule { }
