import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FacturaComponent } from 'src/app/pages/factura/factura.component';
import { MenuTrabajadoresComponent } from 'src/app/pages/menuTrabajadores/menuTrabajadores.component';

export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'MenuAdministradores',component: MenuTrabajadoresComponent},
       {path:'FacturaCentro',component: FacturaComponent},
       {path: '**', redirectTo: ''}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdministradorRoutingModule { }
