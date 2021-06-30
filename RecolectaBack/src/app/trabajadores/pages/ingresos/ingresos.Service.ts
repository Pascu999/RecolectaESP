import {GeneracionIngreso, Ingreso} from './ingreso';
import { Injectable } from '@angular/core';
import {Observable} from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Celda } from './celda';


@Injectable({
    providedIn: 'root'
})

export class IngresosServicio{

    private apiServerUrl = environment.apiBaseUrl;

    constructor(private http: HttpClient){}
    
        public crearIngreso(ingreso: GeneracionIngreso):Observable<Celda>{
        return this.http.post<any>(`${this.apiServerUrl}/Ingresos/Crear`,ingreso);
    }
    
}