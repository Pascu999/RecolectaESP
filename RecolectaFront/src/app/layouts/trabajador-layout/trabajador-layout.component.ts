import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-trabajador-layout',
  templateUrl: './trabajador-layout.component.html',
  styleUrls: ['./trabajador-layout.component.css']
})
export class TrabajadorLayoutComponent implements OnInit, OnDestroy {

  test: Date = new Date();
  public isCollapsed = true;

  constructor(private router : Router) { }

  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");
    this.router.events.subscribe((event) => {
      this.isCollapsed = true;
   });

  }
  ngOnDestroy() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.remove("bg-default");
  }

}
