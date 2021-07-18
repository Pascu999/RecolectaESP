import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AppRoutingModule } from './app.routing';
import { ComponentsModule } from './components/components.module';
import { AdministradorLayoutComponent } from './layouts/administradorLayout/administradorLayout.component';
import { TrabajadorLayoutComponent } from './layouts/trabajadorLayout/trabajadorLayout.component';
import { ContratistaLayoutComponent } from './layouts/contratistaLayout/contratistaLayout.component';
import { TrabajadorLoginComponent } from './pages/trabajadorLogin/trabajadorLogin.component';
import { ContratistaLoginComponent } from './pages/contratistasLogin/contratistaLogin.component';

@NgModule({
  imports: [
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    ComponentsModule,
    RouterModule,
    AppRoutingModule,
    NgbModule,
  ],
  declarations: [
    AppComponent,
    AdministradorLayoutComponent,
    TrabajadorLayoutComponent,
    ContratistaLayoutComponent,
    TrabajadorLoginComponent,
    ContratistaLoginComponent,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
