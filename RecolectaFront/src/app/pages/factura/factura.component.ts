import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { IngresosProyeccion } from 'src/app/models/ingresosProyeccion';
import { FacturaService } from 'src/app/services/factura.service';

@Component({
  selector: 'app-factura',
  templateUrl: './factura.component.html',
  styleUrls: ['./factura.component.scss']
})
export class FacturaComponent implements OnInit {

  private factura_id: Number;
  private Factura : Factura ;
  private Ingresos: IngresosProyeccion[];

  constructor(private router: Router, private facturaServicio : FacturaService,private aRoute : ActivatedRoute) { }

  ngOnInit(): void {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

    this.factura_id = Number(this.aRoute.snapshot.paramMap.get("factura_id"));
    this.obtenerFactura(this.factura_id);
    this.obtenerIngresosFactura(this.factura_id);
  }

   obtenerFactura(factura_id: Number): void {
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

   obtenerIngresosFactura(factura_id: Number): void{
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

   cerrarFactura(){
     let contratistaLoggeado = localStorage.getItem("contratista_id");

     if(contratistaLoggeado != null){
       this.router.navigateByUrl("/Contratistas/menuContratistas");

     }
     else{
       this.router.navigateByUrl("/Administradores/menuAdministradores");
     }

   }


}
