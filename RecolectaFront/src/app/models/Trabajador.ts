import { CentroDisposicion } from "./centroDisposicion";

export interface Trabajador {
    trabajadorId: number;
    centroDisposicion: CentroDisposicion;
    trabajadorNombre: String;
    trabajadorApellido: String;
    trabajadorDocumento: String;
    trabajadorCelular: String;
    trabajadorCorreo: String;
    trabajadorDireccion: String;
    trabajadorTipo: number;
    trabajadorFecha_ingreso: Date;
    trabajadorFecha_nacimiento: Date;
    trabajadorContrasena: number;
    trabajadorEstado: number;

}

