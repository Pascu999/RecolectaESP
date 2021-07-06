import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { MenuTrabajadoresService } from 'src/app/services/menu-trabajadores.service';



@Component({
  selector: 'app-menuTrabajadores',
  templateUrl: './menuTrabajadores.component.html',
  styleUrls: ['./menuTrabajadores.component.scss']
})
export class MenuTrabajadoresComponent implements OnInit {

  private FacturasCentro: Factura[];


  constructor(private menuTrabajadoresServicio: MenuTrabajadoresService, public router: Router) { }

  ngOnInit() {
    let centro_disposicion = Number(localStorage.getItem("centro_disposicion_id"));
    this.menuTrabajadoresServicio.obtenerFacturasCentro(centro_disposicion).subscribe(
      (response: Factura[]) => {
        this.FacturasCentro = response;

        console.log(this.FacturasCentro);
      },
      (error: any)=>{
        console.error(error);
        
      }
    )



  }
}
