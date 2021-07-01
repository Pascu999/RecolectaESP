import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';



const routes: Routes = [
  {
    path: 'Autenticacion',
    loadChildren: () => import('./Routes/autenticacion/autenticacion.module').then(m => m.AutenticacionModule)
  },
  {
    path: 'Contratistas',
    loadChildren: () => import('./Routes/contratistas/contratistas.module').then(m => m.ContratistasModule)
  },
  {
    path: 'Trabajadores',
    loadChildren: () => import('./Routes/trabajadores/trabajadores.module').then(m => m.TrabajadoresModule)
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
