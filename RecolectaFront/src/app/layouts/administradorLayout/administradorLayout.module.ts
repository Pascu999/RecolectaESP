import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdministradorFacturasComponent } from 'src/app/pages/administradorFacturas/administradorFacturas.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdministradorLayoutRoutingModule } from './administradorLayout.routing';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';



@NgModule({
  declarations: [
    AdministradorFacturasComponent
  ],
  imports: [
    AdministradorLayoutRoutingModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatSelectModule,
    MatInputModule,
    MatSortModule,
    MatTableModule,
    MatPaginatorModule
  ],
  bootstrap:[AdministradorFacturasComponent]
})
export class AdministradorLayoutModule { }
