export interface Trabajador {
    trabajadorId: Number;
    centroDisposicion: CentroDisposicion;
    trabajador_nombre: String;
    trabajador_apellido: String;
    trabajador_documento: String;
    trabajador_celular: String;
    trabajador_correo: String;
    trabajador_direccion: String;
    trabajador_tipo: Number;
    trabajador_fecha_ingreso: Date;
    trabajador_fecha_nacimiento: Date;
    trabajador_contrasena: Number;
    trabajador_estado: Number;

}

interface CentroDisposicion{

    centroDisposicionId: Number

}