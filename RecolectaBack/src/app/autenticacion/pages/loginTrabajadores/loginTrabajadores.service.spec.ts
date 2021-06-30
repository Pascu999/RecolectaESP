import { TestBed } from '@angular/core/testing';

import { LoginTrabajadoresService } from './loginTrabajadores.service';

describe('LoginTrabajadoresService', () => {
  let service: LoginTrabajadoresService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LoginTrabajadoresService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
