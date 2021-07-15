import { Contratista } from "./contratista";
import { Ruta } from "./ruta";
import { Tipo } from "./tipo";

export interface Vehiculo {
    vehiculoId :  number,
    contratista : Contratista,
    ruta: Ruta,
    tipo: Tipo,
    vehiculoMarca: string,
    vehiculoPlaca : string,
    vehiculoPeso: number,
    vehiculoModelo: string,
    vehiculoFechaCreacion: Date,
    vehiculoEstado: number

}

export interface VehiculoRegistro{
    contratista:  {contratistaId:number},
    ruta: {rutaId:number},
    tipo: {tipoId:number},
    vehiculoMarca: string,
    vehiculoPlaca: string,
    vehiculoPeso: number,
    vehiculoModelo: string,
    vehiculoFechaCreacion: string
    
  }
  