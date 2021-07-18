import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';




import { ContratistasLayoutRoutingModule } from './contratistaLayout.routing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { VehiculoRegistrarComponent } from 'src/app/pages/vehiculoRegistrar/vehiculoRegistrar.component';
import { MatInputModule } from "@angular/material/input";
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { TablafacturasComponent } from 'src/app/pages/facturasTabla/tablaFacturas.component';
import { VehiculosTablaComponent } from 'src/app/pages/vehiculosTabla/vehiculosTabla.component';

@NgModule({
  declarations: [
    VehiculoRegistrarComponent,
    TablafacturasComponent,
    VehiculosTablaComponent
  ],
  imports: [
    ContratistasLayoutRoutingModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatSelectModule,
    MatInputModule,
    MatSortModule,
    MatTableModule,
    MatPaginatorModule

  ]
})
export class ContratistasLayoutModule { }
