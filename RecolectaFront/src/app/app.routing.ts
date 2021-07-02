import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdministradorLayoutComponent } from './layouts/administrador-layout/administrador-layout.component';
import { ContratistaLayoutComponent } from './layouts/contratista-layout/contratista-layout.component';
import { TrabajadorLayoutComponent } from './layouts/trabajador-layout/trabajador-layout.component';



const routes: Routes = [
  {
    path: 'Autenticacion',
    loadChildren: () => import('./routes/autenticacion/autenticacion.module').then(m => m.AutenticacionModule)
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
    loadChildren: () => import('./layouts/administrador-layout/administrador-layout.component').then(m => m.AdministradorLayoutComponent)
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
