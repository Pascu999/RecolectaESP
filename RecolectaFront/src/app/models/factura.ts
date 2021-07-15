import { CentroDisposicion } from "./centroDisposicion";
import { Contratista } from "./contratista";

export interface Factura{
    facturaId : number
    facturaCostoTransporte: number
    facturaDescuento:number
    facturaFinPeriodo: Date
    facturaInicioPeriodo: Date
    centroDisposicion : CentroDisposicion
    contratista: Contratista

}