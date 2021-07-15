import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';




import { ContratistasRoutingModule } from './contratistas-layout.routing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { RegistrarVehiculoComponent } from 'src/app/pages/registrarVehiculo/registrarVehiculo.component';
import { MatInputModule } from "@angular/material/input";
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { TablafacturasComponent } from 'src/app/pages/tablaFacturas/tablaFacturas.component';
import { TablavehiculosComponent } from 'src/app/pages/tablaVehiculos/tablaVehiculos.component';

@NgModule({
  declarations: [
    RegistrarVehiculoComponent,
    TablafacturasComponent,
    TablavehiculosComponent
  ],
  imports: [
    ContratistasRoutingModule,
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
export class ContratistasModule { }
