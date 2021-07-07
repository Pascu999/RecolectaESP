import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Contratista } from '../models/contratista';

@Injectable({
  providedIn: 'root'
})
export class LoginContratistasServicio {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }
  public SolicitudLoggin(contratista_nit: String, contratista_contrasena: String): Observable<Contratista> {
    return this.http.get<Contratista>(`${this.apiServerUrl}/Contratistas/SolicitudLoggin/${contratista_nit}/${contratista_contrasena}`);
  }
}
