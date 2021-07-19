import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { ContratistaFacturasService } from 'src/app/services/contratistaFacturas.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import Swal from 'sweetalert2';


//Información a mostrar de las facturas en la tabla
declare interface facturasTabla {
  id: number,
  inicio: Date,
  fin: Date,
  centro: string,
  valor: number,

}


@Component({
  selector: 'app-tablafacturas',
  templateUrl: './contratistaFacturas.component.html',
  styleUrls: ['./contratistaFacturas.component.scss']
})

export class TablafacturasComponent implements OnInit {

  private facturasContratista: facturasTabla[] = []; //Facturas pertenecientes al contratista
  private columnasFacturas: string[] = ['inicio', 'fin', 'centro', 'valor', 'info'];//Columnas a mostrar en la tabla
  private dataSourceFacturas: MatTableDataSource<facturasTabla>
  private UltimaFacturacion: String;//Ultima facturación del contratista
  private contratista: number;//Contratista al que se le presentarán sus tablas

  private facturaAux: facturasTabla = {
    id: null,
    inicio: null,
    fin: null,
    centro: null,
    valor: null,
  }

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;




  constructor(private menuContratistasServicio: ContratistaFacturasService, private router: Router) { }

  ngOnInit() {
    //Se generan las facturas
    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.generarMenuFacturas();

  }

  generarMenuFacturas() {
    this.menuContratistasServicio.obtenerFacturasContratista(this.contratista).subscribe(
      (response: Factura[]) => {

        //Se obtienen las facturas del contratista y se agrega la información que se va a mostrar de ellas al arreglo
        response.forEach(factura => {
          this.facturaAux = {
            id: factura.facturaId,
            inicio: factura.facturaInicioPeriodo,
            fin: factura.facturaFinPeriodo,
            centro: factura.centroDisposicion.centroDisposicionNombre,
            valor: factura.facturaCostoTransporte
          }

          this.facturasContratista.push(this.facturaAux)
        })

        //Datasource para la tabla y su correspondiende sorter y paginator
        this.dataSourceFacturas = new MatTableDataSource<facturasTabla>(this.facturasContratista);
        this.dataSourceFacturas.sort = this.sort;
        this.dataSourceFacturas.paginator = this.paginator;

        //Se obtiene la fecha de la ultima facturación del contratista
        this.menuContratistasServicio.obtenerUltimaFacturacionContratista(this.contratista).subscribe(
          (response: String) => {
            this.UltimaFacturacion = response;

          }
        )

      },
      (error: any) => {
        console.log(error);
      }
    )

  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceFacturas.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceFacturas.paginator) {
      this.dataSourceFacturas.paginator.firstPage();
    }
  }

  generarFacturas() {
    Swal.fire({
      title: '¡Generando Facturas!',
      didOpen: () => {
        // Muestra un spinner mientras el servicio envia la respuesta
        Swal.showLoading();
        this.menuContratistasServicio.generarFacturacion().subscribe(
          (response: any) => {
            Swal.close();
            location.reload();
          },
          (error: any) => {
            console.error(error);

          }
        )
      }
    });






  }

}
