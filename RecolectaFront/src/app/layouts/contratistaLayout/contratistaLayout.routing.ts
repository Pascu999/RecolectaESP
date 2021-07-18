import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { VehiculoRegistrarComponent } from 'src/app/pages/vehiculoRegistrar/vehiculoRegistrar.component';
import { TablafacturasComponent } from 'src/app/pages/contratistaFacturas/contratistaFacturas.component';
import { VehiculosTablaComponent } from 'src/app/pages/vehiculosTabla/vehiculosTabla.component';

//Rutas del contratista
export const routesContratista: Routes = [
  {
    path:'',
    children:[
      
       {path:'menuContratistas',component: TablafacturasComponent},
       {path:'menuVehiculos',component: VehiculosTablaComponent},
       {path:'registrarVehiculo',component: VehiculoRegistrarComponent},
       {path:'editarVehiculo/:vehiculo_placa',component: VehiculoRegistrarComponent},
       {path: '**', redirectTo: 'menuContratistas'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routesContratista)],
  exports: [RouterModule]
})
export class ContratistasLayoutRoutingModule { }
