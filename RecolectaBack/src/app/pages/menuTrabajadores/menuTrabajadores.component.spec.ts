import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { MenuContratistasComponent } from './menuTrabajadores.component';

describe('DashboardComponent', () => {
  let component: MenuContratistasComponent;
  let fixture: ComponentFixture<MenuContratistasComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ MenuContratistasComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MenuContratistasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
