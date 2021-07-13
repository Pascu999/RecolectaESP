import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

declare interface RouteInfo {
    path: string;
    title: string;
    icon: string;
    class: string;
}
export const rutasAdministrador: RouteInfo[] = [
    { path: '/Trabajadores', title: 'Administrar Sedes',  icon: 'ni-building text-primary', class: '' }
];

export const rutasContratista: RouteInfo[] = [
  { path: '/Contratistas/menuContratistas', title: 'Menú principal',  icon: 'ni-istanbul text-primary', class: '' },
  { path: '/Contratistas/administrarVehiculos', title: 'Administrar Vehículos',  icon: 'ni-settings text-primary', class: '' },
  { path: '/Contratistas/registrarVehiculo', title: 'Registrar Vehículo',  icon: 'ni-ambulance text-primary', class: '' }
  
];


@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {

  public showRutasTrabajador :boolean = false ;
  public showRutasContratista :boolean = false ;

  public href: string = "";

  public prueba : String = "xd";

  public menuTrabajador: any[];
  public menuContratista: any[];
  public isCollapsed = true;

  

  constructor(private router: Router) { }

  ngOnInit() {
    this.href = this.router.url;
    if(this.href  == "/Administradores/MenuAdministradores"){
      this.showRutasTrabajador = true;
    }
    else if(this.href == "/Contratistas/menuContratistas" || this.href == "/Contratistas/administrarVehiculos" || this.href == "/Contratistas/registrarVehiculo" || this.href.includes("/Contratistas/editarVehiculo/")){
      this.showRutasContratista = true;
    }
    
    this.menuTrabajador = rutasAdministrador.filter(menuItem => menuItem);
    this.menuContratista = rutasContratista.filter(menuItem => menuItem);
    
  }

  cerrarSesion(){
    localStorage.clear();
    if(this.href  == "/Administradores/MenuAdministradores"){
      this.router.navigateByUrl("/LoginTrabajador");
    }
    else if(this.href == "/Contratistas/menuContratistas" || this.href == "/Contratistas/administrarVehiculos" || this.href == "/Contratistas/registrarVehiculo" || this.href.includes("/Contratistas/editarVehiculo/")){
      this.router.navigateByUrl("/LoginContratista");
    }
  }
}


