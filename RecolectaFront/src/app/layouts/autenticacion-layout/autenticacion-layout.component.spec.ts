import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AutenticacionLayoutComponent } from './autenticacion-layout.component';

describe('AutenticacionLayoutComponent', () => {
  let component: AutenticacionLayoutComponent;
  let fixture: ComponentFixture<AutenticacionLayoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AutenticacionLayoutComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AutenticacionLayoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
