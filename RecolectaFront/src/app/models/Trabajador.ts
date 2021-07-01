import { CentroDisposicion } from "./centroDisposicion";

export interface Trabajador {
    trabajadorId: Number;
    centroDisposicion: CentroDisposicion;
    trabajadorNombre: String;
    trabajadorApellido: String;
    trabajadorDocumento: String;
    trabajadorCelular: String;
    trabajadorCorreo: String;
    trabajadorDireccion: String;
    trabajadorTipo: Number;
    trabajadorFecha_ingreso: Date;
    trabajadorFecha_nacimiento: Date;
    trabajadorContrasena: Number;
    trabajadorEstado: Number;

}

