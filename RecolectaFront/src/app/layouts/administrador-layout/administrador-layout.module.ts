import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ContratistasRoutingModule } from '../contratista-layout/contratistas-layout.routing';
import { MenuTrabajadoresComponent } from 'src/app/pages/menuTrabajadores/menuTrabajadores.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdministradorRoutingModule } from './administrador-layout.routing';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';



@NgModule({
  declarations: [
    MenuTrabajadoresComponent
  ],
  imports: [
    AdministradorRoutingModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatSelectModule,
    MatInputModule,
    MatSortModule,
    MatTableModule,
    MatPaginatorModule
  ],
  bootstrap:[MenuTrabajadoresComponent]
})
export class AdministradorModule { }
