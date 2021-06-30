import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IngresosComponente } from './pages/ingresos/ingresos.component';



const routes: Routes = [
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
export class TrabajadoresRoutingModule { }
