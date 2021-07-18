import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Municipio } from '../models/municipio';
import { Ruta } from '../models/ruta';
import { Tipo } from '../models/tipo';
import { Vehiculo, VehiculoRegistro } from '../models/vehiculo';

@Injectable({
  providedIn: 'root'
})
export class VehiculoRegistrarService {

  private apiServerUrl = environment.apiBaseUrl;
  constructor(private http: HttpClient) { }

  public obtenerMunicipios(): Observable<Municipio[]>{
    return this.http.get<Municipio[]>(`${this.apiServerUrl}/Municipios/obtener`);
  }

  public obtenerRutasMunicipio(municipio_id : Number): Observable<Ruta[]>{
    return this.http.get<Ruta[]>(`${this.apiServerUrl}/Rutas/obtenerRutas/${municipio_id}`);
  }

  public obtenerTiposVehiculos(): Observable<Tipo[]>{
    return this.http.get<Tipo[]>(`${this.apiServerUrl}/Vehiculos/Tipos/buscar`);
  }

  public registrarVehiculo(vehiculo : VehiculoRegistro): Observable<Vehiculo>{
    return this.http.post<Vehiculo>(`${this.apiServerUrl}/Vehiculos/Crear`,vehiculo);
  }

  public editarVehiculo(vehiculo: VehiculoRegistro,vehiculo_id : Number): Observable<Vehiculo>{
    return this.http.put<Vehiculo>(`${this.apiServerUrl}/Vehiculos/Actualizar/${vehiculo_id}`,vehiculo);
  }

  public obtenerVehiculo(vehiculo_placa: String): Observable<Vehiculo>{
    return this.http.get<Vehiculo>(`${this.apiServerUrl}/Vehiculos/Consultar/${vehiculo_placa}`);
}

}
