import { Municipio } from "./municipio";

export interface CentroDisposicion{
    centroDisposicionId: number
    centroDisposicionNombre : string
    centroDisposicionDireccion: string
    centroDisposicionCorreo: string
    centroDisposicionCelular: string
    municipio: Municipio

}