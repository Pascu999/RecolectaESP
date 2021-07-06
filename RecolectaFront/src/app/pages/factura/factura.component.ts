import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { FacturaService } from 'src/app/services/factura.service';

@Component({
  selector: 'app-factura',
  templateUrl: './factura.component.html',
  styleUrls: ['./factura.component.css']
})
export class FacturaComponent implements OnInit {


  private Factura : Factura

  constructor(private router: Router, private facturaServicio : FacturaService) { }

  ngOnInit(): void {
    localStorage.setItem("factura_id","2")
    var factura = Number(localStorage.getItem("factura_id"));
    this.obtenerFactura(factura);
  }

  public obtenerFactura(factura_id: Number): void {
     this.facturaServicio.obtenerFacturasCentro(factura_id).subscribe(
       (response: Factura)=>{
       this.Factura = response
       console.log(this.Factura); 
       }
     ),
     (error: any)=>{
       console.log(error);
       
     }

  }


}
