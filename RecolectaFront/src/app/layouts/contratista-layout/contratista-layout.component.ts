import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-contratista-layout',
  templateUrl: './contratista-layout.component.html',
  styleUrls: ['./contratista-layout.component.scss']
})
export class ContratistaLayoutComponent implements OnInit {

  constructor(private router: Router) { }

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
