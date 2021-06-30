import {Ingreso} from './ingreso';
import { Injectable } from '@angular/core';
import {Observable} from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';


@Injectable({
    providedIn: 'root'
})

export class IngresosServicio{

    private apiServerUrl = environment.apiBaseUrl;

    constructor(private http: HttpClient){}
    
        public crearIngreso(ingreso: Ingreso):Observable<Ingreso[]>{
            return this.http.post<any>(`${this.apiServerUrl}/Ingresos/obtenerIngresosFactura`,ingreso);
        }
        public obtenerIngresosFactura(factura_id: Number): Observable<Ingreso[]>{
            return this.http.get<any>(`${this.apiServerUrl}/Ingresos/ObtenerIngresosFactura/${factura_id}`);

        }
    
}