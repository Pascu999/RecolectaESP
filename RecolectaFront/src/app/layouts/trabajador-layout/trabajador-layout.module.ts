import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { IngresosComponente } from 'src/app/pages/ingresos/ingresos.component';
import { TrabajadorRoutingModule } from './trabajador-layout.routing';

@NgModule({
  declarations: [
    IngresosComponente],
  imports: [
    CommonModule,
    FormsModule,
    TrabajadorRoutingModule,
    NgbModule
  ],
  bootstrap:[IngresosComponente]
})
export class TrabajadorModule { }
