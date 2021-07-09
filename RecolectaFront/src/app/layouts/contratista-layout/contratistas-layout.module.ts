import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';



import { MenuContratistasComponent } from '../../pages/menuContratistas/menuContratistas.component';
import { ContratistasRoutingModule } from './contratistas-layout.routing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';


@NgModule({
  declarations: [MenuContratistasComponent],
  imports: [
    CommonModule,
    ContratistasRoutingModule,
    FormsModule,
    ReactiveFormsModule
    
  ]
})
export class ContratistasModule { }
