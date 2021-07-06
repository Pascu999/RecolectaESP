import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MenuTrabajadoresComponent } from 'src/app/pages/menuTrabajadores/menuTrabajadores.component';

export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'Menu',component: MenuTrabajadoresComponent},
       {path: '**', redirectTo: ''}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdministradorRoutingModule { }
