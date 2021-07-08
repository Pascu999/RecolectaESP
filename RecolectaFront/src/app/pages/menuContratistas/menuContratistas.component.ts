import { Component, OnInit } from '@angular/core'; import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { Vehiculo } from 'src/app/models/vehiculo';
import { MenuContratistasService } from 'src/app/services/menu-contratistas.service';
;

@Component({
  selector: 'app-menuContratistas',
  templateUrl: './menuContratistas.component.html',
  styleUrls: ['./menuContratistas.component.scss']
})





export class MenuContratistasComponent implements OnInit {

  private FacturasContratista: Factura[];
  private VehiculosContratista: Vehiculo[];

  public showFacturas: boolean;
  public showVehiculos: boolean;
  public href: string = "";

  private UltimaFacturacion: String;

  constructor(private menuContratistasServicio: MenuContratistasService, private router: Router) { }
  ngOnInit() {

    let contratista = Number(localStorage.getItem("contratista_id"));
    this.href = this.router.url

    if (this.href == '/Contratistas/menuContratistas') {

      this.menuContratistasServicio.obtenerFacturasContratista(contratista).subscribe(
        (response: Factura[]) => {
          this.FacturasContratista = response;
          this.UltimaFacturacion = localStorage.getItem("ultima_facturacion")

          this.showFacturas = true;
          console.log(this.showFacturas);
        },
        (error: any) => {
          console.log(error);
        }
      )


    }
    else if (this.href == '/Contratistas/administrarVehiculos') {

      this.menuContratistasServicio.obtenerVehiculosContratista(contratista).subscribe(
        (response: Vehiculo[]) => {
          this.VehiculosContratista = response;
          this.showVehiculos = true;
          console.log(this.VehiculosContratista);
        },
        (error: any) => {
          console.log(error);
        }
      )


    }



  }

}
