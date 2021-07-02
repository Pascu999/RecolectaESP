import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IngresosComponente } from 'src/app/pages/ingresos/ingresos.component';



export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'registrarIngreso',component: IngresosComponente},
       {path: '**', redirectTo: 'registrarIngreso'}
    ]
  }
]


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TrabajadorRoutingModule { }
