import { Component, NgModule, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { Municipio } from 'src/app/models/municipio';
import { Ruta } from 'src/app/models/ruta';
import { Tipo } from 'src/app/models/tipo';
import { Vehiculo, VehiculoRegistro } from 'src/app/models/vehiculo';
import { registrarVehiculosService } from 'src/app/services/registrarVehiculos.service';


interface MunicipioLista {
  municipio_id: Number;
  municipio_nombre: String;
}

interface RutaLista {
  ruta_id: Number;
  ruta_nombre: String;
}

interface MarcaVehiculo {
  vehiculo_marca_codigo: Number;
  vehiculo_marca: String;
}

interface modeloVehiculo {
  vehiculo_modelo_codigo: Number;
  vehiculo_modelo: String;
}

interface TipoLista{
  tipo_id: Number;
  tipo_nombre: String;
}




@Component({
  selector: 'app-registrarVehiculo',
  templateUrl: './registrarVehiculo.component.html',
  styleUrls: ['./registrarVehiculo.component.scss']
})

@NgModule({
  imports: [MatSelectModule]
})



export class RegistrarVehiculoComponent implements OnInit {

 

  public municipios: MunicipioLista[] = [];
  public rutas: RutaLista[] = [];
  public tipos: TipoLista[] = [];


  private municipioAux: MunicipioLista = {
    municipio_id: null,
    municipio_nombre: null
  }
  private rutaAux: RutaLista = {
    ruta_id: null,
    ruta_nombre: null
  }

  private tipoAux: TipoLista ={
    tipo_id: null,
    tipo_nombre: null
  }

  private marcas: MarcaVehiculo[] = [
    { vehiculo_marca: 'Chevrolet', vehiculo_marca_codigo: 1 },
    { vehiculo_marca: 'Dodge', vehiculo_marca_codigo: 2 },
    { vehiculo_marca: 'Ford', vehiculo_marca_codigo: 3 },
    { vehiculo_marca: 'Hino', vehiculo_marca_codigo: 4 },
    { vehiculo_marca: 'Hyundai', vehiculo_marca_codigo: 5 },
    { vehiculo_marca: 'Kenworth', vehiculo_marca_codigo: 6 },
    { vehiculo_marca: 'Mercedes Benz', vehiculo_marca_codigo: 7 },
    { vehiculo_marca: 'Mitsubishi', vehiculo_marca_codigo: 8 },
    { vehiculo_marca: 'Volvo', vehiculo_marca_codigo: 9 }
  ]

  private modelos: modeloVehiculo[] = [
    { vehiculo_modelo: '2013', vehiculo_modelo_codigo: 1 },
    { vehiculo_modelo: '2014', vehiculo_modelo_codigo: 2 },
    { vehiculo_modelo: '2015', vehiculo_modelo_codigo: 3 },
    { vehiculo_modelo: '2016', vehiculo_modelo_codigo: 4 },
    { vehiculo_modelo: '2017', vehiculo_modelo_codigo: 5 },
    { vehiculo_modelo: '2018', vehiculo_modelo_codigo: 6 },
    { vehiculo_modelo: '2019', vehiculo_modelo_codigo: 7 },
    { vehiculo_modelo: '2020', vehiculo_modelo_codigo: 8 },
    { vehiculo_modelo: '2021', vehiculo_modelo_codigo: 9 }
  ]

  












  //VEHICULO INGRESO

  public contratistaId:Number;
  public municipioIdSeleccionado: Number;
  public rutaIdSeleccionado: Number;
  public marcaSeleccionada: String;
  public modeloSeleccionado: String;
  public tipoVehiculoSeleccionado: Number;
  public pesoVehiculoSeleccionado: Number;
  public placaVehiculo: String;

  //VEHICULO EDITADO
  
  public municipioIdEditado: Number;
  public rutaVehiculoEditadoId: Number;
  public marcaVehiculoEditado: String;
  public modeloVehiculoEditado: String;
  public tipoNombreVehiculoEditado: String;
  public tipoIdVehiculoEditado: Number;
  public pesoVehiculoEditado: Number;
  public placaVehiculoEditado: String;


  private showRegistro : Boolean = false;
  private showEdicion  : Boolean = true;
  private vehiculoEditar : String = '2T1BU4EE0DC075978';
  private vehiculoIdEditar : Number;

  constructor(private registrarVehiculosService: registrarVehiculosService) { }

  ngOnInit(): void {
    this.obtenerMunicipios();
    this.obtenerTiposVehiculo();
    this.obtenerVehiculoEditar(this.vehiculoEditar);
    this.contratistaId = Number(localStorage.getItem("contratista_id"))

  }

  obtenerFecha(): String {
    fecha: String;
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = String(today.getFullYear());

    return mm + '/' + dd + '/' + yyyy;

  }

  obtenerMunicipios() {
    this.registrarVehiculosService.obtenerMunicipios().subscribe(
      (response: Municipio[]) => {


        response.forEach(municipio => {
          this.municipioAux = {

            municipio_id: municipio.municipioId,
            municipio_nombre: municipio.municipioNombre
          }
          this.municipios.push(this.municipioAux);
        })

      }

    )
  }

  obtenerRutasMunicipio(municipio_id: Number) {


    this.registrarVehiculosService.obtenerRutasMunicipio(municipio_id).subscribe(

      (response: Ruta[]) => {
        this.rutas = []
        response.forEach(ruta => {
          this.rutaAux = {
            ruta_id: ruta.rutaId,
            ruta_nombre: ruta.rutaNombre
          }
          this.rutas.push(this.rutaAux);
        })
      }

    )
  }

  obtenerTiposVehiculo() {

    this.registrarVehiculosService.obtenerTiposVehiculos().subscribe(

      (response: Tipo[]) => {
        response.forEach(tipo => {
          this.tipoAux = {
            tipo_id: tipo.tipoId,
            tipo_nombre: tipo.tipoNombre
          }
          this.tipos.push(this.tipoAux);
        })
      }

    )
  }
  obtenerVehiculoEditar(vehiculo_placa: String){
    this.registrarVehiculosService.obtenerVehiculo(vehiculo_placa).subscribe(
      (response: Vehiculo)=>{
        this.vehiculoIdEditar = response.vehiculoId;
        this.marcaVehiculoEditado = response.vehiculoMarca
        this.tipoNombreVehiculoEditado = response.tipo.tipoNombre
        this.tipoIdVehiculoEditado = response.tipo.tipoId
        this.modeloVehiculoEditado = response.vehiculoModelo
        this.pesoVehiculoEditado = response.vehiculoPeso
        this.placaVehiculoEditado = response.vehiculoPlaca
      }
    )
  }

  onCrearVehiculo(vehiculoForm: NgForm){

    console.log("XD");
    

     let nuevoVehiculo : VehiculoRegistro = {
      contratista : {contratistaId:this.contratistaId},
      ruta : {rutaId: this.rutaIdSeleccionado},
      tipo: {tipoId: this.tipoVehiculoSeleccionado},
      vehiculoMarca: this.marcaSeleccionada,
      vehiculoPlaca: this.placaVehiculo,
      vehiculoPeso: this.pesoVehiculoSeleccionado,
      vehiculoModelo: this.modeloSeleccionado,
      vehiculoFechaCreacion: this.obtenerFecha()
     }
      
     console.log(nuevoVehiculo);
     
     this.registrarVehiculosService.registrarVehiculo(nuevoVehiculo).subscribe(
       (response:Vehiculo)=>{
         console.log(response);
         
       }
     )
  }

  onEditarVehiculo(formVehiculo : NgForm){

    let editadoVehiculo  = {
      vehiculoId: this.vehiculoIdEditar,
      contratista : {contratistaId:this.contratistaId},
      ruta : {rutaId: this.rutaVehiculoEditadoId},
      tipo: {tipoId: this.tipoIdVehiculoEditado},
      vehiculoMarca: this.marcaVehiculoEditado,
      vehiculoPlaca: this.placaVehiculoEditado,
      vehiculoPeso: this.pesoVehiculoEditado,
      vehiculoModelo: this.modeloVehiculoEditado,
      vehiculoFechaCreacion: this.obtenerFecha()
     }

     this.registrarVehiculosService.editarVehiculo(editadoVehiculo,this.vehiculoIdEditar).subscribe(
       (response: Vehiculo)=>{
         console.log(response);
         
       }
     )
      


  }

}
