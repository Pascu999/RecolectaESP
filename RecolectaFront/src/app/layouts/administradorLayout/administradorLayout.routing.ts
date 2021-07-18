import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdministradorMenuComponent } from 'src/app/pages/administradorMenu/administradorMenu.component';

export const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'MenuAdministradores',component: AdministradorMenuComponent},
       {path: '**', redirectTo: 'MenuAdministradores'}
    ]
  }
]

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdministradorLayoutRoutingModule { }
