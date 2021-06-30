import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { IngresosComponente } from './pages/ingresos/ingresos.component';
import { TrabajadoresRoutingModule } from './trabajadores-routing.module';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    IngresosComponente],
  imports: [
    CommonModule,
    FormsModule,
    TrabajadoresRoutingModule
  ],
  bootstrap:[IngresosComponente]
})
export class TrabajadoresModule { }
