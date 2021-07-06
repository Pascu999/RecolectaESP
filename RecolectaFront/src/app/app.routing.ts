import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdministradorLayoutComponent } from './layouts/administrador-layout/administrador-layout.component';
import { ContratistaLayoutComponent } from './layouts/contratista-layout/contratista-layout.component';
import { TrabajadorLayoutComponent } from './layouts/trabajador-layout/trabajador-layout.component';
import { LoginContratistaComponent } from './pages/loginContratistas/loginContratista.component';
import { LoginTrabajadorComponent } from './pages/loginTrabajadores/loginTrabajador.component';



const routes: Routes = [
  {
    path: 'LoginTrabajador',
    component: LoginTrabajadorComponent
  },
  {
    path: 'LoginContratista',
    component: LoginContratistaComponent
  },
  {
    path: 'Contratistas',
    component: ContratistaLayoutComponent,
    loadChildren: () => import('./layouts/contratista-layout/contratistas-layout.module').then(m => m.ContratistasModule)
  },
  {
    path: 'Trabajadores',
    component:  TrabajadorLayoutComponent,
    loadChildren: () => import('./layouts/trabajador-layout/trabajador-layout.module').then(m => m.TrabajadorModule)
  },
  {
    path: 'Administradores',
    component:  AdministradorLayoutComponent,
    loadChildren: () => import('./layouts/administrador-layout/administrador-layout.module').then(m => m.AdministradorModule )
  },

  

  {
    path: '**',
    redirectTo: 'Autenticacion'
  },


];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [
    RouterModule
  ]
})
export class AppRoutingModule { }
