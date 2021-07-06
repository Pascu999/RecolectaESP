import { CentroDisposicion } from "./centroDisposicion";
import { Contratista } from "./contratista";

export interface Factura{
    facturaId : Number
    facturaCostoTransporte: Number
    facturaDescuento:Number
    facturaFinPeriodo: Date
    facturaInicioPeriodo: Date
    centroDisposicion : CentroDisposicion
    contratista: Contratista

}