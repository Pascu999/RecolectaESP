import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContratistaLayoutComponent } from './contratista-layout.component';

describe('ContratistaLayoutComponent', () => {
  let component: ContratistaLayoutComponent;
  let fixture: ComponentFixture<ContratistaLayoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ContratistaLayoutComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ContratistaLayoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
