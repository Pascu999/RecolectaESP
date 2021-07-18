import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FacturaComponent } from './components/factura/factura.component';
import { AdministradorLayoutComponent } from './layouts/administradorLayout/administradorLayout.component';
import { ContratistaLayoutComponent } from './layouts/contratistaLayout/contratistaLayout.component';
import { TrabajadorLayoutComponent } from './layouts/trabajadorLayout/trabajadorLayout.component';
import { ContratistaLoginComponent } from './pages/contratistasLogin/contratistaLogin.component';
import { TrabajadorLoginComponent } from './pages/trabajadorLogin/trabajadorLogin.component';

const routes: Routes = [
  {
    path: 'LoginTrabajador',
    component: TrabajadorLoginComponent
  },
  {
    path: 'LoginContratista',
    component: ContratistaLoginComponent
  },
  {
    path: 'Factura/:factura_id',
    component: FacturaComponent
  }
  ,
  {
    path: 'Contratistas',
    component: ContratistaLayoutComponent,
    loadChildren: () => import('./layouts/contratistaLayout/contratistaLayout.module').then(m => m.ContratistasLayoutModule)
  },
  {
    path: 'Trabajadores',
    component:  TrabajadorLayoutComponent,
    loadChildren: () => import('./layouts/trabajadorLayout/trabajadorLayout.module').then(m => m.TrabajadorLayoutModule)
  },
  {
    path: 'Administradores',
    component:  AdministradorLayoutComponent,
    loadChildren: () => import('./layouts/administradorLayout/administradorLayout.module').then(m => m.AdministradorLayoutModule )
  },
  {
    path: '**',
    redirectTo: 'LoginTrabajador'
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
