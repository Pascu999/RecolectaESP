import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule, Routes } from '@angular/router';
import { LoginContratistaComponent } from '../../pages/loginContratistas/loginContratista.component';
import { LoginTrabajadorComponent } from '../../pages/loginTrabajadores/loginTrabajador.component';


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

  imports: [RouterModule.forChild(routes)],

  exports:[FormsModule]
})
export class AutenticacionRoutingModule { }
