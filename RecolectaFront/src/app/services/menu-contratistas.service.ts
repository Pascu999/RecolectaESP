import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Factura } from '../models/factura';
import { Vehiculo } from '../models/vehiculo';

@Injectable({
  providedIn: 'root'
})
export class MenuContratistasService {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }

  public obtenerFacturasContratista(contratista_id  : Number): Observable<Factura[]>{
    return this.http.get<Factura[]>(`${this.apiServerUrl}/Facturas/obtenerFacturasContratista/${contratista_id}`);
  }

  public obtenerVehiculosContratista(contratista_id : Number): Observable<Vehiculo[]>{
    return this.http.get<Vehiculo[]>(`${this.apiServerUrl}/Vehiculos/Listar/${contratista_id}`);
  }

}
