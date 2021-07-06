import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Factura } from '../models/factura';
import { IngresosProyeccion } from '../models/ingresosProyeccion';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }

  public obtenerFacturasCentro(factura_id: Number): Observable<Factura>{
    return this.http.get<Factura>(`${this.apiServerUrl}/Facturas/ObtenerFactura/${factura_id}`);
  }

  public obtenerIngresosFactura(factura_id: Number): Observable<IngresosProyeccion[]>{
    return this.http.get<IngresosProyeccion[]>(`${this.apiServerUrl}/Ingresos/obtenerIngresosFactura/${factura_id}`);
  }

}
