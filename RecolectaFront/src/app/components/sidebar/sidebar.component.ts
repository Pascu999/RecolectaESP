import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

declare interface RouteInfo {
    path: string;
    title: string;
    icon: string;
    class: string;
}
export const rutasTrabajador: RouteInfo[] = [
    { path: '/Trabajadores', title: 'Administrar Sedes',  icon: 'ni-building text-primary', class: '' }
];

export const rutasContratista: RouteInfo[] = [
  { path: '/Contratistas/AdministrarVehiculos', title: 'Administrar Vehículos',  icon: 'ni-bus-front-12 text-primary', class: '' }
];


@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {

  public showRutasTrabajador :boolean = false ;
  public showRutasContratista :boolean = false ;

  public prueba : String = "xd";

  public menuTrabajador: any[];
  public menuContratista: any[];
  public isCollapsed = true;

  

  constructor(private router: Router) { }

  ngOnInit() {
    if(localStorage.getItem("trabajador_id") != null){
      this.showRutasTrabajador = true;
    }
    else if(localStorage.getItem("contratista_id")!= null){
      this.showRutasContratista = true;
    }
    this.menuTrabajador = rutasTrabajador.filter(menuItem => menuItem);
    this.menuContratista = rutasContratista.filter(menuItem => menuItem);
    
  }
}
