import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { IngresosComponente } from './pages/ingresos/ingresos.component';
import { TrabajadoresRoutingModule } from './trabajadores-routing.module';

@NgModule({
  declarations: [
    IngresosComponente],
  imports: [
    CommonModule,
    TrabajadoresRoutingModule
  ]
})
export class TrabajadoresModule { }
