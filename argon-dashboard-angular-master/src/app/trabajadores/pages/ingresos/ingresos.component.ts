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

@NgModule({
  exports:[]
})

export class IngresosComponente implements OnInit {
  
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
 