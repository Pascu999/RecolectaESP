import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoginContratistaComponent } from './loginContratista.component';

describe('LoginContratistaComponent', () => {
  let component: LoginContratistaComponent;
  let fixture: ComponentFixture<LoginContratistaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoginContratistaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoginContratistaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
