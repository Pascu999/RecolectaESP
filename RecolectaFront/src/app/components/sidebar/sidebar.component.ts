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
  { path: '/Contratistas/menuContratistas', title: 'Facturas',  icon: 'ni-istanbul text-primary', class: '' },
  { path: '/Contratistas/menuVehiculos', title: 'Vehículos',  icon: 'ni-settings text-primary', class: ''  },
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

  public rutaActual: string = "";

  public prueba : String = "xd";

  public menuTrabajador: any[];
  public menuContratista: any[];
  public isCollapsed = true;

  

  constructor(private router: Router) { }

  ngOnInit() {

    //Que rutas se mostrarán en el sidenav
    this.rutaActual = this.router.url;
    if(this.rutaActual  == "/Administradores/MenuAdministradores"){
      this.showRutasTrabajador = true;
    }
    else if(this.rutaActual == "/Contratistas/menuContratistas" || this.rutaActual == "/Contratistas/menuVehiculos" || this.rutaActual == "/Contratistas/registrarVehiculo" || this.rutaActual.includes("/Contratistas/editarVehiculo/")){
      this.showRutasContratista = true;
    }
    
    this.menuTrabajador = rutasAdministrador.filter(menuItem => menuItem);
    this.menuContratista = rutasContratista.filter(menuItem => menuItem);
    
  }

  cerrarSesion(){
    localStorage.clear();
    if(this.rutaActual  == "/Administradores/MenuAdministradores"){
      this.router.navigateByUrl("/LoginTrabajador");
    }
    else if(this.rutaActual.includes("/Contratistas")){
      this.router.navigateByUrl("/LoginContratista");
    }
  }
}


