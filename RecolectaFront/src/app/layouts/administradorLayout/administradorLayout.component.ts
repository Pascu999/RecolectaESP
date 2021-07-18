import { Component, NgModule, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-administradorLayout',
  templateUrl: './administradorLayout.component.html',
  styleUrls: ['./administradorLayout.component.scss']
})

@NgModule({
  
})
export class AdministradorLayoutComponent implements OnInit {

  constructor(private router : Router) { }

  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");
    this.router.events.subscribe((event) => {
   });

  }
  ngOnDestroy() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.remove("bg-default");
  }

}
