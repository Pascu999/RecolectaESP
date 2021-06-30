import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';



const routes: Routes = [
  {
    path: 'Autenticacion',
    loadChildren: () => import('./auth/auth.module').then(m => m.AuthModule)
  },
  {
    path: 'Contratistas',
    loadChildren: () => import('./contratistas/contratistas.module').then(m => m.ContratistasModule)
  },
  {
    path: 'Trabajadores',
    loadChildren: () => import('./trabajadores/trabajadores.module').then(m => m.TrabajadoresModule)
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
