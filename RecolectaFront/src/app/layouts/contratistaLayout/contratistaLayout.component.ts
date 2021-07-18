import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-contratistaLayout',
  templateUrl: './contratistaLayout.component.html',
  styleUrls: ['./contratistaLayout.component.scss']
})
export class ContratistaLayoutComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.add("bg-default");
  }
  ngOnDestroy() {
    var body = document.getElementsByTagName("body")[0];
    body.classList.remove("bg-default");
  }

}
