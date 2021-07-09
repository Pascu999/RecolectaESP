import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MenuContratistasComponent } from 'src/app/pages/menuContratistas/menuContratistas.component';
import { RegistrarVehiculoComponent } from 'src/app/pages/registrarVehiculo/registrarVehiculo.component';

export const routesContratista: Routes = [
  {
    path:'',
    children:[
      
       {path:'menuContratistas',component: MenuContratistasComponent},
       {path:'administrarVehiculos',component: MenuContratistasComponent},
       {path:'registrarVehiculo',component: RegistrarVehiculoComponent},
       {path:'editarVehiculo',component: RegistrarVehiculoComponent},
       {path: '**', redirectTo: 'menuContratistas'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routesContratista)],
  exports: [RouterModule]
})
export class ContratistasRoutingModule { }
