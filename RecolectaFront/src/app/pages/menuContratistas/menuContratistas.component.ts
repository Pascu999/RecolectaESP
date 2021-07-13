import { Component, OnInit, Pipe,PipeTransform } from '@angular/core'; import { Router } from '@angular/router';
import { Factura } from 'src/app/models/factura';
import { Vehiculo } from 'src/app/models/vehiculo';
import { MenuContratistasService } from 'src/app/services/menu-contratistas.service';
;

@Component({
  selector: 'app-menuContratistas',
  templateUrl: './menuContratistas.component.html',
  styleUrls: ['./menuContratistas.component.scss']
})

@Pipe({name: 'transformarEstado'})



export class MenuContratistasComponent implements OnInit,PipeTransform {

  private FacturasContratista: Factura[];
  private VehiculosContratista: Vehiculo[];

  public showFacturas: boolean;
  public showVehiculos: boolean;
  public href: string = "";
  public contratista: Number;

  private UltimaFacturacion: String;

  transform(input: Number):String{
    if(input == 0){
      return 'activar'
    }
    else if(input == 1){
      return 'desactivar'
    }
  }

  constructor(private menuContratistasServicio: MenuContratistasService, private router: Router) { }
  ngOnInit() {

    this.contratista = Number(localStorage.getItem("contratista_id"));
    this.href = this.router.url

    if (this.href == '/Contratistas/menuContratistas') {

      this.generarMenuFacturas();

    }
    else if (this.href == '/Contratistas/administrarVehiculos') {

  
      this.generarMenuVehiculos();

    }



  }

  generarMenuFacturas(){
    this.menuContratistasServicio.obtenerFacturasContratista(this.contratista).subscribe(
      (response: Factura[]) => {
        this.FacturasContratista = response;
        this.menuContratistasServicio.obtenerUltimaFacturacionContratista(this.contratista).subscribe(
          (response: String)=>{
            this.UltimaFacturacion = response;
            this.showFacturas = true;
            console.log(this.showFacturas);
          }
        )

      },
      (error: any) => {
        console.log(error);
      }
    )

  }

  generarMenuVehiculos(){
    this.menuContratistasServicio.obtenerVehiculosContratista(this.contratista).subscribe(
      (response: Vehiculo[]) => {
        this.VehiculosContratista = response;
        this.showVehiculos = true;
        console.log(this.contratista);
        
        console.log(this.VehiculosContratista);
      },
      (error: any) => {
        console.log(error);
      }
    )
  }

  cambiarEstado(vehiculo_id : Number){
    console.log(vehiculo_id);

    this.menuContratistasServicio.cambiarEstadoVehiculo(vehiculo_id).subscribe(
      (response: any)=>{
        console.log(response);
        this.generarMenuVehiculos();
      }
    )
  }

  generarFacturas(){
    console.log("Facturando");
    this.menuContratistasServicio.generarFacturacionContratista(this.contratista).subscribe(
      (response:any)=>{
        console.log(response);
        this.generarMenuFacturas();

      },
      (error:any)=>{
        console.error(error);
        
      }
    )



    
  }

 

}
