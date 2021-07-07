import { Component, OnInit } from '@angular/core';import { Factura } from 'src/app/models/factura';
import { FacturaService } from 'src/app/services/factura.service';
import { MenuContratistasService } from 'src/app/services/menu-contratistas.service';
;

@Component({
  selector: 'app-menuContratistas',
  templateUrl: './menuContratistas.component.html',
  styleUrls: ['./menuContratistas.component.scss']
})
export class MenuContratistasComponent implements OnInit {

  private FacturasContratista: Factura[];

  private UltimaFacturacion:String;

  constructor(private menuContratistasServicio: MenuContratistasService){}
  ngOnInit() {
    console.log(localStorage.getItem("ultima_facturacion"));
    
    let contratista = Number(localStorage.getItem("contratista_id"));
    this.menuContratistasServicio.obtenerFacturasContratista(contratista).subscribe(
      (response: Factura[])=>{
        this.FacturasContratista = response;
        this.UltimaFacturacion = localStorage.getItem("ultima_facturacion")
        console.log(this.FacturasContratista);
      },
      (error: any)=>{
        console.log(error);
      }
    )
  }

}
