import { Contratista } from "./contratista";
import { Ruta } from "./ruta";
import { Tipo } from "./tipo";

export interface Vehiculo {
    vehiculoId :  Number,
    contratista : Contratista,
    ruta: Ruta,
    tipo: Tipo,
    vehiculoMarca: String,
    vehiculoPlaca : String,
    vehiculoPeso: Number,
    vehiculoModelo: String,
    vehiculoFechaCreacion: String,
    vehiculoEstado: Number

}

export interface VehiculoRegistro{
    contratista:  {contratistaId:Number},
    ruta: {rutaId:Number},
    tipo: {tipoId:Number},
    vehiculoMarca: String,
    vehiculoPlaca: String,
    vehiculoPeso: Number,
    vehiculoModelo: String,
    vehiculoFechaCreacion: String
    
  }
  