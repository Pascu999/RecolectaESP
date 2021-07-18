import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InstruccionIngresoComponent } from 'src/app/pages/instruccionIngreso/instruccionIngreso.component';
import { IngresoComponent } from 'src/app/pages/ingreso/ingresos.component';



export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'registrarIngreso',component: IngresoComponent},
       {path:'instruccionIngreso/:celda_ingresar',component: InstruccionIngresoComponent},
       {path: '**', redirectTo: 'registrarIngreso'}
    ]
  }
]


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TrabajadorLayoutRoutingModule { }
