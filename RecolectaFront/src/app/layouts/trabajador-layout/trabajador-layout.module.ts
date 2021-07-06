import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { IngresosComponente } from 'src/app/pages/ingresos/ingresos.component';
import { TrabajadorRoutingModule } from './trabajador-layout.routing';
import { IngresoInstruccionComponent } from 'src/app/pages/ingresoInstruccion/ingresoInstruccion.component';

@NgModule({
  declarations: [
    IngresosComponente,
    IngresoInstruccionComponent],
  imports: [
    CommonModule,
    FormsModule,
    TrabajadorRoutingModule,
    NgbModule
  ],
  bootstrap:[IngresosComponente]
})
export class TrabajadorModule { }
