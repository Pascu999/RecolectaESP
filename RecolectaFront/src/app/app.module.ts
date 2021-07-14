import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { AppRoutingModule } from './app.routing';
import { ComponentsModule } from './components/components.module';
import { AdministradorLayoutComponent } from './layouts/administrador-layout/administrador-layout.component';
import { TrabajadorLayoutComponent } from './layouts/trabajador-layout/trabajador-layout.component';
import { ContratistaLayoutComponent } from './layouts/contratista-layout/contratista-layout.component';
import { LoginTrabajadorComponent } from './pages/loginTrabajadores/loginTrabajador.component';
import { FacturaComponent } from './pages/factura/factura.component';
import { LoginContratistaComponent } from './pages/loginContratistas/loginContratista.component';
import { RegistrarVehiculoComponent } from './pages/registrarVehiculo/registrarVehiculo.component';
import { MatSelectModule } from '@angular/material/select';
import {MatTableModule} from '@angular/material/table';


@NgModule({
  imports: [
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    ComponentsModule,
    RouterModule,
    AppRoutingModule,
    NgbModule,
    MatSelectModule,
    MatTableModule
  ],
  declarations: [
    AppComponent,
    AdministradorLayoutComponent,
    TrabajadorLayoutComponent,
    ContratistaLayoutComponent,
    LoginTrabajadorComponent,
    LoginContratistaComponent,
    FacturaComponent,
    RegistrarVehiculoComponent,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
