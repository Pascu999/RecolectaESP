import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { TrabajadoresRoutingModule } from './trabajadores-routing.module';
import { FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { IngresosComponente } from 'src/app/pages/ingresos/ingresos.component';
import { MatSelectModule} from '@angular/material/select'

@NgModule({
  declarations: [
    IngresosComponente],
  imports: [
    CommonModule,
    FormsModule,
    TrabajadoresRoutingModule,
    NgbModule,
    MatSelectModule
  ],
  bootstrap:[IngresosComponente]
})
export class TrabajadoresModule { }
