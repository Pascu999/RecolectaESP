import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdministradorFacturasComponent } from 'src/app/pages/administradorFacturas/administradorFacturas.component';

//Rutas del administrador
export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'MenuAdministradores',component: AdministradorFacturasComponent},
       {path: '**', redirectTo: 'MenuAdministradores'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdministradorLayoutRoutingModule { }
