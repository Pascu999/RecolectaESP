import { HttpErrorResponse } from '@angular/common/http';
import { Component, NgModule, OnInit } from '@angular/core';
import { ComponentsModule } from 'src/app/components/components.module';
import { Ingreso } from './ingreso';
import { IngresosServicio } from './ingresos.Service';

@Component({
  selector: 'app-ingresos',
  templateUrl: './ingresos.component.html',
  styleUrls: ['./ingresos.component.scss']
})


export class IngresosComponente implements OnInit {

  ingreso : Ingreso={
    ingreso_id: 1,
    vehiculo_id: 1,
    conductor_id: 1,
    desecho_id: 1,
    trabajador_id: 1,
    celda_id: 1,
    factura_id: 1,
    ingreso_peso: 1,
    ingreso_valor_transporte: 1,
    ingreso_peso_sobrecarga: 1,
    ingreso_valor_sobrecarga: 1,
    ingreso_fecha: new Date(),


  }
  
  public ingresos: Ingreso[];
  constructor(private ingresoServicio:  IngresosServicio){}

  ngOnInit() {
  }


  public obtenerIngresosFactura(factura_id : Number):void{
    this.ingresoServicio.obtenerIngresosFactura(factura_id).subscribe(
    (response: Ingreso[])=> {

      this.ingresos = response;
      console.log(this.ingresos);
      

    },
    (error: HttpErrorResponse) =>{
      alert(error.message);
      console.log(error.message); 
      
    }
    )
  }

  

 

}
 