import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Factura } from '../models/factura';

@Injectable({
  providedIn: 'root'
})
export class MenuTrabajadoresService {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }

  public obtenerFacturasCentro(centro_disposicion_id: Number): Observable<Factura[]>{
    return this.http.get<Factura[]>(`${this.apiServerUrl}/Facturas/obtenerFacturasCentro/${centro_disposicion_id}`);
  }

}
