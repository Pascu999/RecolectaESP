import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Trabajador } from '../models/trabajador';

@Injectable({
  providedIn: 'root'
})
export class LoginTrabajadoresService {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }
  public SolicitudLoggin(trabajador_documento: String, trabajador_contrasena: String): Observable<Trabajador> {
    return this.http.get<any>(`${this.apiServerUrl}/Trabajadores/SolicitudLoggin/${trabajador_documento}/${trabajador_contrasena}`);

  }
}
