import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IngresosComponente } from './ingresos.component';

describe('RegisterComponent', () => {
  let component: IngresosComponente;
  let fixture: ComponentFixture<IngresosComponente>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IngresosComponente ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IngresosComponente);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
