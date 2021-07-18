import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { IngresoComponent } from 'src/app/pages/ingreso/ingresos.component';
import { TrabajadorLayoutRoutingModule } from './trabajadorLayout.routing';
import { InstruccionIngresoComponent } from 'src/app/pages/instruccionIngreso/instruccionIngreso.component';

@NgModule({
  declarations: [
    IngresoComponent,
    InstruccionIngresoComponent],
  imports: [
    CommonModule,
    FormsModule,
    TrabajadorLayoutRoutingModule,
    NgbModule
  ],
  bootstrap:[IngresoComponent]
})
export class TrabajadorLayoutModule { }
