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

  private factura_id: Number;// Id de la factura que se mostrará en pantalla
  private detalles_factura = {}// Detalles de la factura que se mostrarán
  private Ingresos: IngresosProyeccion[];//Ingresos pertenecientes a la factura

  constructor(private router: Router, private facturaServicio: FacturaService, private aRoute: ActivatedRoute) { }

  ngOnInit(): void {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

    this.factura_id = Number(this.aRoute.snapshot.paramMap.get("factura_id"));

    this.obtenerFactura(this.factura_id);
  }

  obtenerFactura(factura_id: Number): void {
    //Se usa el servicio de factura para obtener la información de la factura a mostrar
    this.facturaServicio.obtenerFacturasCentro(factura_id).subscribe(
      (response: Factura) => {
        this.detalles_factura ={
          contratistaNombre : response.contratista.contratistaNombre,
          contratistaDireccion : response.contratista.contratistaDireccion,
          contratistaCelular : response.contratista.contratistaCelular,
          contratistaCorreo : response.contratista.contratistaCorreo,
          centroDisposicionNombre : response.centroDisposicion.centroDisposicionNombre,
          centroDisposicionDireccion : response.centroDisposicion.centroDisposicionDireccion,
          centroDisposicionCorreo : response.centroDisposicion.centroDisposicionCorreo,
          facturaId : response.facturaId,
          facturaCostoTransporte : response.facturaCostoTransporte,
          facturaDescuento : response.facturaDescuento,
          facturaFinPeriodo : response.facturaFinPeriodo,
          facturaInicioPeriodo : response.facturaInicioPeriodo
        };
        
        
        this.obtenerIngresosFactura(this.factura_id);
        return response
      }
    ),
      (error: any) => {
        console.log(error);
      }
  }

  //Obtener ingresos a detallar de la factura
  obtenerIngresosFactura(factura_id: Number): void {
    this.facturaServicio.obtenerIngresosFactura(factura_id).subscribe(
      (response: IngresosProyeccion[]) => {

        
        this.Ingresos = response
        console.log(this.Ingresos);


      },
      (error: any) => {
        console.log(error);
      }
    )
  }

  cerrarFactura() {
    let contratistaLoggeado = localStorage.getItem("contratista_id");

    if (contratistaLoggeado != null) {
      this.router.navigateByUrl("/Contratistas/menuContratistas");

    }
    else {
      this.router.navigateByUrl("/Administradores/menuAdministradores");
    }

  }


}