import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { AdministradorMenuService } from 'src/app/services/administradorMenu.service';



declare interface facturasTabla {
  id: number,
  inicio: Date,
  fin: Date,
  contratista: string,
  valor: number,

}


@Component({
  selector: 'app-administradorMenu',
  templateUrl: './administradorMenu.component.html',
  styleUrls: ['./administradorMenu.component.scss']
})
export class AdministradorMenuComponent implements OnInit {

  private centro: number
  private facturasCentro: facturasTabla[] = [];
  private columnasFacturas: string[] = ['inicio', 'fin', 'contratista', 'valor', 'info'];
  private dataSourceFacturas: MatTableDataSource<facturasTabla>
  private FacturasCentro: Factura[];
  private facturaAux: facturasTabla = {
    id: null,
    inicio: null,
    fin: null,
    contratista: null,
    valor: null,
  }

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;





  constructor(private menuTrabajadoresServicio: AdministradorMenuService, public router: Router) { }

  ngOnInit() {
    this.centro = Number(localStorage.getItem("centro_disposicion_id"));
    this.generarMenuFacturas();


  }

  generarMenuFacturas() {
    this.menuTrabajadoresServicio.obtenerFacturasCentro(this.centro).subscribe(
      (response: Factura[]) => {

        response.forEach(factura => {
          this.facturaAux = {
            id: factura.facturaId,
            inicio: factura.facturaInicioPeriodo,
            fin: factura.facturaFinPeriodo,
            contratista: factura.contratista.contratistaNombre,
            valor: factura.facturaCostoTransporte
          }
          this.facturasCentro.push(this.facturaAux)
        })

        this.dataSourceFacturas = new MatTableDataSource<facturasTabla>(this.facturasCentro);
        this.dataSourceFacturas.sort = this.sort;
        this.dataSourceFacturas.paginator = this.paginator;



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

}
