import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IngresoInstruccionComponent } from 'src/app/pages/ingresoInstruccion/ingresoInstruccion.component';
import { IngresosComponente } from 'src/app/pages/ingresos/ingresos.component';



export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'registrarIngreso',component: IngresosComponente},
       {path:'instruccionIngreso',component: IngresoInstruccionComponent},
       {path: '**', redirectTo: 'registrarIngreso'}
    ]
  }
]


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TrabajadorRoutingModule { }
