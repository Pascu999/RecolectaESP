import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MenuContratistasComponent } from 'src/app/pages/menuContratistas/menuContratistas.component';

export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'menuContratistas',component: MenuContratistasComponent},
       {path: '**', redirectTo: 'menuContratistas'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContratistasRoutingModule { }
