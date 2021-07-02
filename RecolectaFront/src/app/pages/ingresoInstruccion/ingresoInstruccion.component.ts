import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-ingresoInstruccion',
  templateUrl: './ingresoInstruccion.component.html',
  styleUrls: ['./ingresoInstruccion.component.css']
})
export class IngresoInstruccionComponent implements OnInit {

  private celda_ingresar: String ;


  constructor(private router: Router) { }

  ngOnInit(): void {
    let celda_ingreso  = localStorage.getItem("celda_nombre");
    if(celda_ingreso == null){
      this.router.navigateByUrl("/Trabajadores/registrarIngreso");
    }
    else{
        this.celda_ingresar = localStorage.getItem("celda_nombre");
    }
  }


  public onCerrarInstruccion(){
    localStorage.removeItem("celda_nombre");
    this.router.navigateByUrl("/Trabajadores/registrarIngreso");
  }
}