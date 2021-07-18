import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-instruccionIngreso',
  templateUrl: './instruccionIngreso.component.html',
  styleUrls: ['./instruccionIngreso.component.scss']
})
export class InstruccionIngresoComponent implements OnInit {

  private celda_ingresar: String;//Celda en la que se va a realizar el ingreso


  constructor(private router: Router, private aRoute: ActivatedRoute) { }

  ngOnInit(): void {

    //Se obtiene el parametro de la URL
    this.celda_ingresar = this.aRoute.snapshot.paramMap.get("celda_ingresar");

    if (this.celda_ingresar == null) {
      this.router.navigateByUrl("/Trabajadores/registrarIngreso");
    }
  }


  public onCerrarInstruccion() {
    this.router.navigateByUrl("/Trabajadores/registrarIngreso");
  }
}