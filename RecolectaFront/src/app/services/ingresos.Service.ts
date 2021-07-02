
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { GeneracionIngreso } from '../models/ingreso';
import { Celda } from '../models/celda';
import { Vehiculo } from '../models/vehiculo';
import { Conductor } from '../models/conductor';


@Injectable({
    providedIn: 'root'
})

export class IngresosServicio {
    Respuesta : Vehiculo
        

    private apiServerUrl = environment.apiBaseUrl;

    constructor(private http: HttpClient) { }

    public crearIngreso(ingreso: GeneracionIngreso): Observable<Celda> {
        return this.http.post<Celda>(`${this.apiServerUrl}/Ingresos/Crear`, ingreso);
    }

    public obtenerVehiculo(vehiculo_placa: String): Observable<Vehiculo>{
        console.log(vehiculo_placa);
        
        return this.http.get<Vehiculo>(`${this.apiServerUrl}/Vehiculos/Consultar/${vehiculo_placa}`);
    }

    public obtenerConductor(conductor_documento: String): Observable<Conductor>{
        return this.http.get<Conductor>(`${this.apiServerUrl}/Conductores/Consultar/${conductor_documento}`)
    }

    public obtenerCelda():Observable<Celda>{
        return this.http.get<Celda>(`${this.apiServerUrl}/Ingresos/ConsultarCelda/`)

    }


}