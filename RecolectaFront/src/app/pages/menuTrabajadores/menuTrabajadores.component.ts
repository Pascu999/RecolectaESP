import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { MenuTrabajadoresService } from 'src/app/services/menu-trabajadores.service';



declare interface facturasTabla {
  id: number,
  inicio: Date,
  fin: Date,
  centro: string,
  valor: number,

}


@Component({
  selector: 'app-menuTrabajadores',
  templateUrl: './menuTrabajadores.component.html',
  styleUrls: ['./menuTrabajadores.component.scss']
})
export class MenuTrabajadoresComponent implements OnInit {
  facturasCentro: facturasTabla[] = [];
  columnasFacturas: string[] = ['inicio', 'fin', 'centro', 'valor', 'info'];
  dataSourceFacturas: MatTableDataSource<facturasTabla>
  private FacturasCentro: Factura[];

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  private centro: number

  private facturaAux: facturasTabla = {
    id: null,
    inicio: null,
    fin: null,
    centro: null,
    valor: null,
  }


  constructor(private menuTrabajadoresServicio: MenuTrabajadoresService, public router: Router) { }

  ngOnInit() {
    this.centro = Number(localStorage.getItem("centro_disposicion_id"));
    this.generarMenuFacturas();


  }

  generarMenuFacturas() {
    this.menuTrabajadoresServicio.obtenerFacturasCentro(this.centro).subscribe(
      (response: Factura[]) => {
        console.log(response);
        
        response.forEach(factura => {
          this.facturaAux = {
          id: factura.facturaId,
          inicio: factura.facturaInicioPeriodo,
          fin: factura.facturaFinPeriodo,
          centro: factura.centroDisposicion.centroDisposicionNombre,
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
