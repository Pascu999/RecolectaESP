import { HttpErrorResponse } from '@angular/common/http';
import { Component, NgModule, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Municipio } from 'src/app/models/municipio';
import { Ruta } from 'src/app/models/ruta';
import { Tipo } from 'src/app/models/tipo';
import { Vehiculo, VehiculoRegistro } from 'src/app/models/vehiculo';
import { registrarVehiculosService } from 'src/app/services/registrarVehiculos.service';
import Swal from 'sweetalert2';


//Interfaz para mapear la lista de municipios 
interface municipioLista {
  municipio_id: number;
  municipio_nombre: string;
}

//Interfaz para mapear la lista de rutas asociada a un municipio
interface rutaLista {
  ruta_id: number;
  ruta_nombre: string;
}

//Interfaz para mapear la lista de marcas de vehiculo 
interface marcaVehiculo {
  vehiculo_marca_codigo: number;
  vehiculo_marca: string;
}

//Interfaz para mapear la lista de modelos de vehiculo
interface modeloVehiculo {
  vehiculo_modelo_codigo: number;
  vehiculo_modelo: string;
}

//Interfaz para mapear la lista de tipos de vehiculo 
interface tipoLista{
  tipo_id: number;
  tipo_nombre: string;
}
//Interfaz para mapear los estados disponibles
interface estadoLista {
  estado_id: number;
  estado_nombre: string;
}



@Component({
  selector: 'app-registrarVehiculo',
  templateUrl: './registrarVehiculo.component.html',
  styleUrls: ['./registrarVehiculo.component.scss']
})



export class RegistrarVehiculoComponent implements OnInit {

 
  //Lista de municipios,rutas,tipos,marcas y modelos posibles para elegir
  public municipios: municipioLista[] = [];
  public rutas: rutaLista[] = [];
  public tipos: tipoLista[] = [];

  private marcas: marcaVehiculo[] = [
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

  private estados: estadoLista[] = [
    {estado_id: 1, estado_nombre: 'Activado'},
    {estado_id: 0, estado_nombre: 'Desactivado'}
  ]


  //Objetos de tipo municipoLista con los que se llenara la lista de municipios
  private municipioAux: municipioLista = {
    municipio_id: null,
    municipio_nombre: null
  }

  //Objetos de tipo rutaLista con los que se llenara la lista de rutas
  private rutaAux: rutaLista = {
    ruta_id: null,
    ruta_nombre: null
  }

  //Objetos de tipo t ipoLista con los que se llenara la lista de tipos
  private tipoAux: tipoLista ={
    tipo_id: null,
    tipo_nombre: null
  }



  //Propiedades del vehiculo que se registra

  private contratistaId:number;
  private municipioIdSeleccionado: number;
  private rutaIdSeleccionado: number;
  private marcaSeleccionada: string;
  private modeloSeleccionado: string;
  private tipoVehiculoSeleccionado: number;
  private pesoVehiculoSeleccionado: number;
  private placaVehiculoSeleccionado: string;

  //Propiedades del vehiculo que se edita
  
  private municipioIdEditado: number;
  private rutaVehiculoEditadoId: number;
  private marcaVehiculoEditado: string;
  private modeloVehiculoEditado: string;
  private tipoNombreVehiculoEditado: string;
  private tipoIdVehiculoEditado: number;
  private pesoVehiculoEditado: number;
  private placaVehiculoEditado: string;
  private estadoVehiculoEditado: number;


  private showRegistro : Boolean = false ;
  private showEdicion  : Boolean = false ;
  private vehiculoPlacaEditar : string;
  private vehiculoIdEditar : number;

  constructor(private registrarVehiculosService: registrarVehiculosService,private aRoute: ActivatedRoute, private router : Router) { }

  ngOnInit(): void {

    
    this.vehiculoPlacaEditar = this.aRoute.snapshot.paramMap.get("vehiculo_placa")
    this.contratistaId = Number(localStorage.getItem("contratista_id"))
    this.obtenerMunicipios();
    if(this.router.url == '/Contratistas/registrarVehiculo'){
      this.showRegistro = true
    this.obtenerTiposVehiculo();
    }
    else if(this.vehiculoPlacaEditar != null){
      this.showEdicion = true
      
      this.obtenerVehiculoEditar(this.vehiculoPlacaEditar);
    }
  }

  obtenerFecha(): string {
    let fecha: string;
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

  obtenerRutasMunicipio(municipio_id: number) {

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

  obtenerVehiculoEditar(vehiculo_placa: string){
    this.registrarVehiculosService.obtenerVehiculo(vehiculo_placa).subscribe(
      (response: Vehiculo)=>{
        this.vehiculoIdEditar = response.vehiculoId;
        this.marcaVehiculoEditado = response.vehiculoMarca
        this.tipoNombreVehiculoEditado = response.tipo.tipoNombre
        this.tipoIdVehiculoEditado = response.tipo.tipoId
        this.modeloVehiculoEditado = response.vehiculoModelo
        this.pesoVehiculoEditado = response.vehiculoPeso
        this.placaVehiculoEditado = response.vehiculoPlaca
        this.estadoVehiculoEditado = response.vehiculoEstado

        console.log(this.estadoVehiculoEditado);
        
      }
    )
  }

  onCrearVehiculo(vehiculoForm: NgForm){
     let nuevoVehiculo : VehiculoRegistro = {
      contratista : {contratistaId:this.contratistaId},
      ruta : {rutaId: this.rutaIdSeleccionado},
      tipo: {tipoId: this.tipoVehiculoSeleccionado},
      vehiculoMarca: this.marcaSeleccionada,
      vehiculoPlaca: this.placaVehiculoSeleccionado,
      vehiculoPeso: this.pesoVehiculoSeleccionado,
      vehiculoModelo: this.modeloSeleccionado,
      vehiculoFechaCreacion: this.obtenerFecha()
     }
     
     this.registrarVehiculosService.registrarVehiculo(nuevoVehiculo).subscribe(
       (response:Vehiculo)=>{

        Swal.fire({
          title: 'Vehículo registrado exitosamente',
          icon: 'success',
          confirmButtonText: 'Aceptar',
          width: '20%',
          backdrop: false,
          timer: 3000,
          toast: true,
          position:'top-end'
        })    
        
        this.router.navigateByUrl("/Contratistas/administrarVehiculos")
         console.log(response);
         
       },
       (error: HttpErrorResponse) => {
         if(error.status == 500){
           Swal.fire({
             title: 'Error al registrar el vehículo',
             text: 'Ya hay un vehículo registrado con esta placa',
             icon: 'error',
             confirmButtonText: 'Aceptar',
             width: '20%',
             padding: '1rem',
             heightAuto: true,
             backdrop: true,
             timer: 3000,
             toast:true,
             position:'bottom-end'
           })
 
         }
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
      vehiculoFechaCreacion: this.obtenerFecha(),
      vehiculoEstado: this.estadoVehiculoEditado,
     }
     console.log("NuevoEstado");
     
     console.log(editadoVehiculo.vehiculoEstado);
     this.registrarVehiculosService.editarVehiculo(editadoVehiculo,this.vehiculoIdEditar).subscribe(
       
       
       (response: Vehiculo)=>{
        Swal.fire({
          title: '¡Edición exitosa!',
          icon: 'success',
          confirmButtonText: 'Aceptar',
          width: '20%',
          backdrop: false,
          timer: 3000,
          toast: true,
          position:'top-end'
        })    
        this.router.navigateByUrl("/Contratistas/menuVehiculos")
       }
     )
  }

}
