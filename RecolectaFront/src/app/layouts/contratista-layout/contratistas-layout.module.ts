import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { MenuContratistasComponent } from '../../pages/menuContratistas/menuContratistas.component';
import { ContratistasRoutingModule } from './contratistas-layout.routing';


@NgModule({
  declarations: [MenuContratistasComponent],
  imports: [
    CommonModule,
    ContratistasRoutingModule
  ]
})
export class ContratistasModule { }
