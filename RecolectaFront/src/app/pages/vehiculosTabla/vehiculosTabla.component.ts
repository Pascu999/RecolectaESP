
import { Component, OnInit, Pipe, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Vehiculo } from 'src/app/models/vehiculo';
import { ContratistaMenuService } from 'src/app/services/contratistaMenu.service';
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
  selector: 'app-vehiculosTabla',
  templateUrl: './vehiculosTabla.component.html',
  styleUrls: ['./vehiculosTabla.component.scss']
})

@Pipe({ name: 'transformarEstado' })



export class VehiculosTablaComponent implements OnInit {

  private vehiculosContratista: vehiculosTabla[] = [];
  private columnasVehiculos: string[] = ['ruta', 'placa', 'tipo', 'fechaCreacion', 'estado', 'editar'];
  private dataSourceVehiculos: MatTableDataSource<vehiculosTabla>

  private contratista: number;

  private vehiculoAux: vehiculosTabla = {
    id: null,
    ruta: null,
    placa: null,
    tipo: null,
    estado: null,
    fechaCreacion: null
  }

  

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;


  transform(input: number): string {
    if (input == 0) {
      return 'desactivado'
    }
    else if (input == 1) {
      return 'activado'
    }
  }



  constructor(private menuContratistasServicio: ContratistaMenuService, private router: Router) { }

  ngOnInit() {
    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.generarMenuVehiculos();

  }


  generarMenuVehiculos() {
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





}


