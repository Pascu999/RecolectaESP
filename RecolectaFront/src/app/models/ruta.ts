import { Municipio } from "./municipio";

export interface Ruta {
    rutaId : number,
    rutaNombre : string,
    municipio: Municipio,
    rutaEstado: number
}