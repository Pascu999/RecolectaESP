import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ContratistasRoutingModule } from '../contratista-layout/contratistas-layout.routing';
import { MenuTrabajadoresComponent } from 'src/app/pages/menuTrabajadores/menuTrabajadores.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { FormsModule } from '@angular/forms';
import { AdministradorRoutingModule } from './administrador-layout.routing';



@NgModule({
  declarations: [
    MenuTrabajadoresComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    AdministradorRoutingModule,
    NgbModule
  ],
  bootstrap:[MenuTrabajadoresComponent]
})
export class AdministradorModule { }
