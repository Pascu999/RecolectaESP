import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-trabajadorLayout',
  templateUrl: './trabajadorLayout.component.html',
  styleUrls: ['./trabajadorLayout.component.scss']
})
export class TrabajadorLayoutComponent implements OnInit, OnDestroy {

  test: Date = new Date();
  public isCollapsed = true;

  constructor(private router : Router) { }

  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");

  }
  ngOnDestroy() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.remove("bg-default");
  }

  cerrarSesion(){
    localStorage.clear();
    if(this.router.url.includes("/Trabajadores")){
      this.router.navigateByUrl("/LoginTrabajador")
    }
  }

}
