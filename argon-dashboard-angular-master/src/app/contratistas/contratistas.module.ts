import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ContratistasRoutingModule } from './contratistas-routing.module';
import { MenuContratistasComponent } from './pages/menuContratistas/menuContratistas.component';


@NgModule({
  declarations: [MenuContratistasComponent],
  imports: [
    CommonModule,
    ContratistasRoutingModule
  ]
})
export class ContratistasModule { }
