export interface Ingreso {
    ingreso_id: number;
    vehiculo_id: number;
    conductor_id: number;
    desecho_id: number;
    trabajador_id: number;
    celda_id: number;
    factura_id: number;
    ingreso_peso: number;
    ingreso_valor_transporte: number;
    ingreso_peso_sobrecarga: number;
    ingreso_valor_sobrecarga: number;
    ingreso_fecha: String;
    ingreso_estado: number;

}
export interface GeneracionIngreso {
    ingreso_peso: number;
    conductor_id: number;
    desecho_id: number;
    trabajador_id: number;
    contratista_id: number;
    vehiculo_id: number;
    centro_disposicion_id: number

}