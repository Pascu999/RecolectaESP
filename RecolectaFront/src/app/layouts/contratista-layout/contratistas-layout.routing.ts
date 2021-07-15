import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RegistrarVehiculoComponent } from 'src/app/pages/registrarVehiculo/registrarVehiculo.component';
import { TablafacturasComponent } from 'src/app/pages/tablaFacturas/tablaFacturas.component';
import { TablavehiculosComponent } from 'src/app/pages/tablaVehiculos/tablaVehiculos.component';

export const routesContratista: Routes = [
  {
    path:'',
    children:[
      
       {path:'menuContratistas',component: TablafacturasComponent},
       {path:'menuVehiculos',component: TablavehiculosComponent},
       {path:'registrarVehiculo',component: RegistrarVehiculoComponent},
       {path:'editarVehiculo/:vehiculo_placa',component: RegistrarVehiculoComponent},
       {path: '**', redirectTo: 'menuContratistas'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routesContratista)],
  exports: [RouterModule]
})
export class ContratistasRoutingModule { }
