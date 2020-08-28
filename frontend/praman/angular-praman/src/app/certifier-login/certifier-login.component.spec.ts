import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CertifierLoginComponent } from './certifier-login.component';

describe('CertifierLoginComponent', () => {
  let component: CertifierLoginComponent;
  let fixture: ComponentFixture<CertifierLoginComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CertifierLoginComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CertifierLoginComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
