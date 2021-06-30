import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginContratistaComponent } from './pages/loginContratistas/loginContratista.component';
import { LoginTrabajadorComponent } from './pages/loginTrabajadores/loginTrabajador.component';


const routes: Routes = [
  {
    path:'',
    children:[
      
       {path:'loginContratistas',component:LoginContratistaComponent},
       {path:'loginTrabajadores',component:LoginTrabajadorComponent},
       {path: '**', redirectTo: 'loginTrabajadores'}
    ]
  }
]

@NgModule({
  declarations: [],

  imports: [RouterModule.forChild(routes)
  ]
})
export class AuthRoutingModule { }
