import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoginTrabajadorComponent } from './loginTrabajador.component';

describe('LoginTrabajadorComponent', () => {
  let component: LoginTrabajadorComponent;
  let fixture: ComponentFixture<LoginTrabajadorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoginTrabajadorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoginTrabajadorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
