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
import { AdministradorLayoutModule } from './layouts/administrador-layout/administrador-layout.module';
import { IngresoInstruccionComponent } from './pages/ingresoInstruccion/ingresoInstruccion.component';
import { AutenticacionLayoutComponent } from './layouts/autenticacion-layout/autenticacion-layout.component';


@NgModule({
  imports: [
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    ComponentsModule,
    RouterModule,
    AppRoutingModule,
    NgbModule,
    AdministradorLayoutModule
  ],
  declarations: [
    AppComponent,
    AdministradorLayoutComponent,
    TrabajadorLayoutComponent,
    ContratistaLayoutComponent,
    IngresoInstruccionComponent,
    AutenticacionLayoutComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
