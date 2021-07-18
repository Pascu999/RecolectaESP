import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { AdministradorMenuService } from 'src/app/services/administradorMenu.service';


//Información a mostrar de las facturas en la tabla
declare interface facturasTabla {
  id: number,
  inicio: Date,
  fin: Date,
  contratista: string,
  valor: number,

}


@Component({
  selector: 'app-administradorFacturas',
  templateUrl: './administradorFacturas.component.html',
  styleUrls: ['./administradorFacturas.component.scss']
})
export class AdministradorFacturasComponent implements OnInit {


  private centro: number //Centro al que pertenece el administrador a quien se le muestran las facturas
  private facturasCentro: facturasTabla[] = []; //Facturas del centro
  private columnasFacturas: string[] = ['inicio', 'fin', 'contratista', 'valor', 'info'];//Columnas a mostrar en la tabla
  private dataSourceFacturas: MatTableDataSource<facturasTabla>
  private facturaAux: facturasTabla = {
    id: null,
    inicio: null,
    fin: null,
    contratista: null,
    valor: null,
  }

  @ViewChild(MatPaginator) paginator: MatPaginator;//Paginator de la tabla
  @ViewChild(MatSort) sort: MatSort;//Sorter de la tabla





  constructor(private menuTrabajadoresServicio: AdministradorMenuService, public router: Router) { }

  ngOnInit() {
    this.centro = Number(localStorage.getItem("centro_disposicion_id"));
    this.generarMenuFacturas();

  }

  generarMenuFacturas() {
    this.menuTrabajadoresServicio.obtenerFacturasCentro(this.centro).subscribe(
      (response: Factura[]) => {

        //Se obtienen las facturas del centro y se agrega la información que se va a mostrar de ellas al arreglo
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

  //Filtro de resultados
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceFacturas.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceFacturas.paginator) {
      this.dataSourceFacturas.paginator.firstPage();
    }
  }

}
