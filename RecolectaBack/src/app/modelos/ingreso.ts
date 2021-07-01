export interface Ingreso {
    ingreso_id: Number;
    vehiculo_id: Number;
    conductor_id: Number;
    desecho_id: Number;
    trabajador_id: Number;
    celda_id: Number;
    factura_id: Number;
    ingreso_peso: Number;
    ingreso_valor_transporte: Number;
    ingreso_peso_sobrecarga: Number;
    ingreso_valor_sobrecarga: Number;
    ingreso_fecha: String;
    ingreso_estado: Number;

}
export interface GeneracionIngreso {
    ingreso_peso: Number;
    conductor_id: Number;
    desecho_id: Number;
    trabajador_id: Number;
    contratista_id: Number;
    vehiculo_id: Number;
    tipo_id: Number;
    centro_disposicion_id: Number,
    ingreso_fecha: String

}