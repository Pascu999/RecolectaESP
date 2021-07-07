import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { IngresosProyeccion } from 'src/app/models/ingresosProyeccion';
import { FacturaService } from 'src/app/services/factura.service';

@Component({
  selector: 'app-factura',
  templateUrl: './factura.component.html',
  styleUrls: ['./factura.component.scss']
})
export class FacturaComponent implements OnInit {


  private Factura : Factura 
  private Ingresos: IngresosProyeccion[]

  constructor(private router: Router, private facturaServicio : FacturaService) { }

  ngOnInit(): void {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");


    var factura = Number(localStorage.getItem("factura_id"));
    this.obtenerFactura(factura);
    this.obtenerIngresosFactura(factura);
  }

  public obtenerFactura(factura_id: Number): void {
     this.facturaServicio.obtenerFacturasCentro(factura_id).subscribe(
       (response: Factura)=>{
         this.Factura = response
       return response
       }
     ),
     (error: any)=>{
       console.log(error);
     }
  }

  public obtenerIngresosFactura(factura_id: Number): void{
    this.facturaServicio.obtenerIngresosFactura(factura_id).subscribe(
      (response: IngresosProyeccion[])=>{
        this.Ingresos = response
        console.log(this.Ingresos);
        
      },
      (error: any)=>{
        console.log(error);
      }
    )
  }


}
