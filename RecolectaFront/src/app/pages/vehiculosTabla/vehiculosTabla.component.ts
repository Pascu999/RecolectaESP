
import { Component, OnInit, Pipe, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Vehiculo } from 'src/app/models/vehiculo';
import { ContratistaFacturasService } from 'src/app/services/contratistaFacturas.service';
import Swal from 'sweetalert2';

//Interfaz de los vehículos que se mostrarán 
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

  private vehiculosContratista: vehiculosTabla[] = [];//Vehiculos pertenecientes al contratista
  private columnasVehiculos: string[] = ['ruta', 'placa', 'tipo', 'fechaCreacion', 'estado', 'editar'];//Columnas a mostrar en la tabla
  private dataSourceVehiculos: MatTableDataSource<vehiculosTabla>
  private contratista: number;//Contratista al que se le presentarán sus vehículos

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



  constructor(private menuContratistasServicio: ContratistaFacturasService, private router: Router) { }

  ngOnInit() {
    //Se generan los vehículos
    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.generarMenuVehiculos();

  }


  generarMenuVehiculos() {
    this.menuContratistasServicio.obtenerVehiculosContratista(this.contratista).subscribe(
      (response: Vehiculo[]) => {

        //Se obtienen las facturas del contratista y se agrega la información que se va a mostrar de ellas al arreglo
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

        //Datasource para la tabla y su correspondiende sorter y paginator
        this.dataSourceVehiculos = new MatTableDataSource<vehiculosTabla>(this.vehiculosContratista)
        this.dataSourceVehiculos.sort = this.sort;
        this.dataSourceVehiculos.paginator = this.paginator;
      },
      (error: any) => {
        console.log(error);
      }
    )
  }

 
  //Filtrado
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceVehiculos.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceVehiculos.paginator) {
      this.dataSourceVehiculos.paginator.firstPage();
    }
  }





}


