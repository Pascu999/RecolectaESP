import { DatePipe } from '@angular/common';
import { AfterViewInit, Component, OnInit, Pipe, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { promise } from 'protractor';
import { Vehiculo } from 'src/app/models/vehiculo';
import { MenuContratistasService } from 'src/app/services/menu-contratistas.service';
import Swal from 'sweetalert2';

declare interface vehiculosTabla {
  id: number,
  ruta: string,
  placa: string,
  tipo: string,
  fechaCreacion: Date,
  estado: number

}


@Component({
  selector: 'app-tablavehiculos',
  templateUrl: './tablavehiculos.component.html',
  styleUrls: ['./tablavehiculos.component.scss']
})

@Pipe({ name: 'transformarEstado' })



export class TablavehiculosComponent implements OnInit {

  vehiculosContratista: vehiculosTabla[] = [];
  columnasVehiculos: string[] = ['ruta', 'placa', 'tipo', 'fechaCreacion','estado', 'editar'];
  dataSourceVehiculos: MatTableDataSource<vehiculosTabla>


  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  public contratista: number;

  private vehiculoAux: vehiculosTabla = {
    id: null,
    ruta: null,
    placa: null,
    tipo: null,
    estado: null,
    fechaCreacion: null
  }

  transform(input: number): string {
    if (input == 0) {
      return 'activado'
    }
    else if (input == 1) {
      return 'desactivado'
    }
  }



  constructor(private menuContratistasServicio: MenuContratistasService, private router: Router) {}
 
  ngOnInit() {
    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.generarMenuVehiculos();

  }

  
  generarMenuVehiculos(){
    this.menuContratistasServicio.obtenerVehiculosContratista(this.contratista).subscribe(
      (response: Vehiculo[]) => {


        response.forEach(vehiculo => {
          this.vehiculoAux = {
            id: vehiculo.vehiculoId,
            ruta: vehiculo.ruta.rutaNombre,
            placa: vehiculo.vehiculoPlaca,
            estado: vehiculo.vehiculoEstado,
            fechaCreacion: vehiculo.vehiculoFechaCreacion,
            tipo: vehiculo.tipo.tipoNombre
          }
          this.vehiculosContratista.push(this.vehiculoAux)
        })
        
        this.dataSourceVehiculos = new MatTableDataSource<vehiculosTabla>(this.vehiculosContratista)
        
        console.log(this.dataSourceVehiculos.data);
        this.dataSourceVehiculos.sort = this.sort;
        this.dataSourceVehiculos.paginator = this.paginator;
      },
      (error: any) => {
        console.log(error);
      }
    )
  }

  cambiarEstado(vehiculo_id: number) {
    this.menuContratistasServicio.cambiarEstadoVehiculo(vehiculo_id).subscribe(
      (response: any) => {
        Swal.fire({
          title: 'Vehiculo desactivado/activado',
          icon: 'warning',
          confirmButtonText: 'Aceptar',
          width: '20%',
          backdrop: false,
          timer: 3000,
          toast: true,
          position: 'top-end'
        })


      }
    )
    

    this.generarMenuVehiculos()

  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceVehiculos.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceVehiculos.paginator) {
      this.dataSourceVehiculos.paginator.firstPage();
    }
  }

  formatoFecha(fecha: Date): Date{
    var fechaString  = String(fecha);
    var fechaDividida = fechaString.split('/')
    var fechaFinal = fechaString[1]+"/"+fechaString[0]+"/"+fechaString[2]
    return new Date(fechaFinal);
  }

 



}


