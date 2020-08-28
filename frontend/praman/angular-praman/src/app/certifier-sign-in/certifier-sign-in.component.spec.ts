import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CertifierSignInComponent } from './certifier-sign-in.component';

describe('CertifierSignInComponent', () => {
  let component: CertifierSignInComponent;
  let fixture: ComponentFixture<CertifierSignInComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CertifierSignInComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CertifierSignInComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
