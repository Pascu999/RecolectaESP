import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { ContratistaMenuService } from 'src/app/services/contratistaMenu.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import Swal from 'sweetalert2';


declare interface facturasTabla {
  id: number,
  inicio: Date,
  fin: Date,
  centro: string,
  valor: number,

}


@Component({
  selector: 'app-tablafacturas',
  templateUrl: './tablaFacturas.component.html',
  styleUrls: ['./tablaFacturas.component.scss']
})

export class TablafacturasComponent implements OnInit {

  private facturasContratista: facturasTabla[] = [];
  private columnasFacturas: string[] = ['inicio', 'fin', 'centro', 'valor', 'info'];
  private dataSourceFacturas: MatTableDataSource<facturasTabla>
  private UltimaFacturacion: String;
  private contratista: number;
  
  private facturaAux: facturasTabla = {
    id: null,
    inicio: null,
    fin: null,
    centro: null,
    valor: null,
  }
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;




  constructor(private menuContratistasServicio: ContratistaMenuService, private router: Router) { }

  ngOnInit() {
    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.generarMenuFacturas();

  }

  generarMenuFacturas() {
    this.menuContratistasServicio.obtenerFacturasContratista(this.contratista).subscribe(
      (response: Factura[]) => {

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

        this.dataSourceFacturas = new MatTableDataSource<facturasTabla>(this.facturasContratista);
        this.dataSourceFacturas.sort = this.sort;
        this.dataSourceFacturas.paginator = this.paginator;

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
        this.menuContratistasServicio.generarFacturacionContratista(this.contratista).subscribe(
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
