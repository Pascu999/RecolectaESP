import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SidebarComponent } from './sidebar/sidebar.component';
import { RouterModule } from '@angular/router';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { FacturaComponent } from './factura/factura.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    NgbModule
    
  ],
  declarations: [
    SidebarComponent,
    FacturaComponent
  ],
  exports: [
    SidebarComponent
  ]
})
export class ComponentsModule { }
